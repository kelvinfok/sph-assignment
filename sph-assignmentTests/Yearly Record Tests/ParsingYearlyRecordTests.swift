//
//  ParsingYearlyRecordTests.swift
//  sph-assignmentTests
//
//  Created by Kelvin Fok on 26/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import XCTest
@testable import sph_assignment

class ParsingYearlyRecordTests: XCTestCase {

    func testParsingYearlyRecordFromQuarterRecords_1() {
        
        let monthlyRecords = [Record(id: 0, volume: "10", quarter: "2010-Q1"),
                              Record(id: 0, volume: "20", quarter: "2010-Q2"),
                              Record(id: 0, volume: "30", quarter: "2010-Q3"),
                              Record(id: 0, volume: "40", quarter: "2010-Q4")]
        
        let feedResult = FeedResult(resourceId: "0", records: monthlyRecords)
        
        if let yearlyRecord = feedResult.getYearlyRecords()?.first {
            let expectedYearlyRecord = YearlyRecord(year: 2010, q1: 10, q2: 20, q3: 30, q4: 40)
            XCTAssertEqual(yearlyRecord, expectedYearlyRecord)
        } else {
            XCTFail()
        }
    }
    
    func testParsingYearlyRecordFromQuarterRecords_2() {
        
        let monthlyRecords = [Record(id: 0, volume: "10.5", quarter: "2010-Q1"),
                              Record(id: 0, volume: "", quarter: "2010-Q2"),
                              Record(id: 0, volume: "20.5", quarter: "2010-Q3"),
                              Record(id: 0, volume: "4", quarter: "2010-Q4")]
        
        let feedResult = FeedResult(resourceId: "0", records: monthlyRecords)
        
        if let yearlyRecords = feedResult.getYearlyRecords() {
            let expectedYearlyRecords = [YearlyRecord(year: 2010, q1: 10.5, q2: nil, q3: 20.5, q4: 4)]
            XCTAssertEqual(yearlyRecords, expectedYearlyRecords)
        } else {
            XCTFail()
        }
    }
    
    func testParsingYearlyRecordFromQuarterRecords_3() {
        
        let monthlyRecords = [Record(id: 0, volume: "10.5", quarter: "2010-Q1"),
                              Record(id: 0, volume: "", quarter: "2010-Q2"),
                              Record(id: 0, volume: "20.5", quarter: "2010-Q3"),
                              Record(id: 0, volume: "4", quarter: "2010-Q4"),
                              Record(id: 0, volume: "25", quarter: "2011-Q1"),
                              Record(id: 0, volume: "35", quarter: "2011-Q3")]
        
        let feedResult = FeedResult(resourceId: "0", records: monthlyRecords)
        
        if let yearlyRecord = feedResult.getYearlyRecords() {
            let expectedYearlyRecords = [YearlyRecord(year: 2010, q1: 10.5, q2: nil, q3: 20.5, q4: 4),
                                        YearlyRecord(year: 2011, q1: 25, q2: nil, q3: 35, q4: nil)]
            XCTAssertEqual(yearlyRecord, expectedYearlyRecords)
        } else {
            XCTFail()
        }
    }

}
