//
//  YearlyTotalConsumptionTests.swift
//  sph-assignmentTests
//
//  Created by Kelvin Fok on 26/6/19.
//  Copyright © 2019 Kelvin Fok. All rights reserved.
//

import XCTest
@testable import sph_assignment

class YearlyTotalConsumptionTests: XCTestCase {
    
    func testYearlyTotalConsumption_1() {
        
        let yearlyRecord = YearlyRecord(year: 2019,
                                        q1: nil,
                                        q2: 30,
                                        q3: nil,
                                        q4: 20)
        
        let totalConsumption = yearlyRecord.totalConsumption
        XCTAssertEqual(totalConsumption, 50)
    }
    
    func testYearlyTotalConsumption_2() {
        
        let yearlyRecord = YearlyRecord(year: 2019,
                                        q1: 25,
                                        q2: 30,
                                        q3: 25,
                                        q4: 20)
        
        let totalConsumption = yearlyRecord.totalConsumption
        XCTAssertEqual(totalConsumption, 100)
    }
    
    func testYearlyTotalConsumption_3() {
        
        let yearlyRecord = YearlyRecord(year: 2019,
                                        q1: nil,
                                        q2: nil,
                                        q3: nil,
                                        q4: nil)
        
        let totalConsumption = yearlyRecord.totalConsumption
        XCTAssertEqual(totalConsumption, 0)
    }
}
