//
//  sph_assignmentTests.swift
//  sph-assignmentTests
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import XCTest
@testable import sph_assignment

class sph_assignmentTests: XCTestCase {

    func testForSuccessfulCall() {

        let successExpectation = self.expectation(description: "Successful call expectation")

        let mockAPIClient = MockAPIClient.init(testType: .SUCCESS)

        mockAPIClient.getFeed { (result) in
            switch result {
            case .success:
                successExpectation.fulfill()
            case .failure:
                XCTFail()
            }
        }

        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testForInternalServerError() {

        let errorExpectation = self.expectation(description: "Internal server error expectation")

        let mockAPIClient = MockAPIClient.init(testType: .INTERNAL_SERVER_ERROR)

        mockAPIClient.getFeed { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let failure):
                if failure == .INTERNAL_SERVER_ERROR {
                    errorExpectation.fulfill()
                }
            }
        }

        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testForInvalidUrlString() {
        
        let errorExpectation = self.expectation(description: "Invalid URL String expectation")
        
        let mockAPIClient = MockAPIClient.init(testType: .INVALID_URL_STRING)
        
        mockAPIClient.getFeed { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let failure):
                if failure == .INVALID_URL_STRING {
                    errorExpectation.fulfill()
                }
            }
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testForIncorrectUrlString() {
        
        let errorExpectation = self.expectation(description: "Incorrect URL String expectation")
        
        let mockAPIClient = MockAPIClient.init(testType: .INCORRECT_URL_STRING)
        
        mockAPIClient.getFeed { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let failure):
                if failure == .CANNOT_PARSE_DATA {
                    errorExpectation.fulfill()
                }
            }
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
    func testForInvalidResource() {
        
        let errorExpectation = self.expectation(description: "Resource not found expectation")
        
        let mockAPIClient = MockAPIClient.init(testType: .RESOURCE_NOT_FOUND)
        
        mockAPIClient.getFeed { (result) in
            switch result {
            case .success:
                XCTFail()
            case .failure(let failure):
                if failure == .RESOURCE_NOT_FOUND {
                    errorExpectation.fulfill()
                }
            }
        }
        
        self.waitForExpectations(timeout: 5.0, handler: nil)
    }
    
}
