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
    
    func getYearlyRecords() -> [YearlyRecord]? {
        
        var yearlyRecords = [YearlyRecord]()
        
        records.forEach { (record) in
            
            guard let year = Int(record.quarter.prefix(4)),
                let quarter = Int(record.quarter.suffix(1)),
                let volume = Double(record.volume) else {
                    print("Error parsing")
                    return }
            
            let yearlyRecord = yearlyRecords.filter({ (record) -> Bool in
                return record.year == year
            }).first
            
            if let yearlyRecord = yearlyRecord {
                switch quarter {
                case 1:
                    yearlyRecord.q1 = volume
                case 2:
                    yearlyRecord.q2 = volume
                case 3:
                    yearlyRecord.q3 = volume
                case 4:
                    yearlyRecord.q4 = volume
                default: break
                }
            } else {
                let newYearlyRecord = YearlyRecord(year: year)
                switch quarter {
                case 1:
                    newYearlyRecord.q1 = volume
                case 2:
                    newYearlyRecord.q2 = volume
                case 3:
                    newYearlyRecord.q3 = volume
                case 4:
                    newYearlyRecord.q4 = volume
                default: break
                }
                yearlyRecords.append(newYearlyRecord)
            }
        }
        
        return yearlyRecords
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

class YearlyRecord: CustomStringConvertible {
    
    let year: Int
    var q1: Double? = nil
    var q2: Double? = nil
    var q3: Double? = nil
    var q4: Double? = nil
    
    var hasDecreasedInMonthly: Bool {
        return true
    }
    
    init(year: Int) {
        self.year = year
    }
    
    var description: String {
        return """
        Year: \(year),
        q1: \(String(describing: q1)),
        q2: \(String(describing: q2)),
        q3: \(String(describing: q3)),
        q4: \(String(describing: q4))
        
        """
    }
    
}
