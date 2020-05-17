//
//  PersianDatePickerTests.swift
//  PersianDatePickerTests
//
//  Created by Farhad on 5/8/17.
//  Copyright © 2017 Farhad. All rights reserved.
//

import XCTest
@testable import PersianDatePicker

class PersianDatePickerTests: XCTestCase {
    
    let datasource = PersianDateDataSource()
    
    func testDaysRangeWith31Days() {
        let rang = datasource.daysRange(ofYear: 1399, month: 1)
        XCTAssertTrue(rang.count == 31)
    }
    
    func testDaysRangeWith30Days() {
        let rang = datasource.daysRange(ofYear: 1399, month: 7)
        XCTAssertTrue(rang.count == 30)
    }
    
    func testGregorianDate() {
        guard
            let gDate = datasource.convertToGregorian(year: 1399,
                                                      month: 2,
                                                      day: 28)
            else {
                XCTFail()
                return
        }
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat  = "yyyy-MM-dd"
        let d = dateFormater.string(from: gDate)
        XCTAssertTrue(d == "2020-05-17")
    }
}
