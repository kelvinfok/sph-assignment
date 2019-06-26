//
//  APIClient.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

protocol APIClientProtocol {
    func getFeed(completion: @escaping (Result<Feed, APIClientError>) -> Void)
}

enum APIClientError: Error {
    case INVALID_URL_STRING
    case RESOURCE_NOT_FOUND
    case NO_DATA_AVAILABLE
    case CANNOT_PARSE_DATA
    case INTERNAL_SERVER_ERROR
}

class APIClient {
    
    var isCachingEnabled = false
    
    func fetch<T: Decodable>(urlString: String, completion: @escaping (Result<T, APIClientError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.INVALID_URL_STRING))
            return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 400...499:
                    completion(.failure(.RESOURCE_NOT_FOUND))
                case 500...599:
                    completion(.failure(.INTERNAL_SERVER_ERROR))
                default: break
                }
            }
            
            guard let jsonData = data else {
                completion(.failure(.NO_DATA_AVAILABLE))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: jsonData)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(.CANNOT_PARSE_DATA))
            }
        }.resume()
    }
    
}

extension APIClient: APIClientProtocol {
    
    func getFeed(completion: @escaping (Result<Feed, APIClientError>) -> Void) {

        let urlString = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        
        let fetchBlock = { [weak self] in
            self?.fetch(urlString: urlString) { (_ result: Result<Feed, APIClientError>) in
                switch result {
                case .success(let feed):
                    CacheManager.shared.addToCache(feed: feed)
                    completion(.success(feed))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
        
        if isCachingEnabled {
            if let feed = CacheManager.shared.retrieveFromCache() {
                print("Fetched from cache")
                completion(.success(feed))
            } else {
                print("Cache is empty, fetch from network")
                fetchBlock()
            }
        } else {
            fetchBlock()
        }
    }
}



