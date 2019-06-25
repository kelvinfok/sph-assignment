//
//  Record.swift
//  sph-assignment
//
//  Created by Kelvin Fok on 25/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import Foundation

struct Feed: Decodable {
    
    let help: String
    let success: Bool
    let result: FeedResult
    
}

struct FeedResult: Decodable {
    
    let resourceId: String
    let records: [Record]
    
    enum CodingKeys: String, CodingKey {
        case resourceId = "resource_id"
        case records = "records"
    }
    
}

struct Record: Decodable {
    
    let id: Int
    let volume: String
    let quarter: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case volume = "volume_of_mobile_data"
        case quarter = "quarter"
    }
}
