//
//  MockAPIClient.swift
//  sph-assignmentTests
//
//  Created by Kelvin Fok on 26/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//
import Foundation
@testable import sph_assignment

class MockAPIClient: APIClientProtocol {
    
    enum TestType {
        case SUCCESS
        case INTERNAL_SERVER_ERROR
        case INVALID_URL_STRING
        case INCORRECT_URL_STRING
        case RESOURCE_NOT_FOUND
    }
    
    let SUCCESS_URL_STRING = "https://data.gov.sg/api/action/datastore_search?resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
    let INVALID_URL_STRING = ""
    let INCORRECT_URL_STRING = "https://api.myjson.com/bins/su9fu"
    let INTERNAL_SERVER_ERROR_URL_STRING = "http://www.mocky.io/v2/5d12de7a0e00003119b4a0bd"
    let RESOURCE_NOT_FOUND_URL_STRING = "https://data.gov.sg/api/$$$action"
    
    var urlString = String()
    
    init(testType: TestType) {
        switch testType {
        case .SUCCESS:
            urlString = SUCCESS_URL_STRING
        case .INVALID_URL_STRING:
            urlString = INVALID_URL_STRING
        case .INTERNAL_SERVER_ERROR:
            urlString = INTERNAL_SERVER_ERROR_URL_STRING
        case .INCORRECT_URL_STRING:
            urlString = INCORRECT_URL_STRING
        case .RESOURCE_NOT_FOUND:
            urlString = RESOURCE_NOT_FOUND_URL_STRING
        }
    }
    
    func getFeed(completion: @escaping (Result<Feed, APIClientError>) -> Void) {
        APIClient().fetch(urlString: urlString, completion: completion)
    }
    
}
