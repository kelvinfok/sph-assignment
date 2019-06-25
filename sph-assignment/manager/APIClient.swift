//
//  APIClient.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

enum APIClientError: Error {
    case INVALID_URL_STRING
    case NO_DATA_AVAILABLE
    case CANNOT_PARSE_DATA
}

class APIClient {
    
    static let shared = APIClient()
    private init() {}
    
    private let urlString = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    
    func fetch(completion: @escaping (Result<Feed, APIClientError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.INVALID_URL_STRING))
            return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.NO_DATA_AVAILABLE))
                return
            }
            do {
                let decoder = JSONDecoder()
                let feedResult = try decoder.decode(Feed.self, from: jsonData)
                completion(.success(feedResult))
            } catch {
                print(error)
                completion(.failure(.CANNOT_PARSE_DATA))
            }
        }.resume()
    }
    
}
