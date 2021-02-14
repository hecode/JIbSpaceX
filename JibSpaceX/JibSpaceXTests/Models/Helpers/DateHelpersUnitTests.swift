//
//  DateHelpersUnitTests.swift
//  JibSpaceXTests
//
//  Created by Ibrahim Beltagy on 14/02/2021.
//  Copyright © 2021 Ibrahim Beltagy. All rights reserved.
//

import XCTest
@testable import JibSpaceX

class DateHelpersUnitTests: XCTestCase {
    
    func testYearsBetweenDates() {
        let date =  Date()
        let difference = yearsBetweenDates(startDate: date, endDate: Calendar.current.date(byAdding: .day, value: 1, to: date))
        XCTAssert(difference == 0)
    }
    
    func testYearsBetweenDates2Years() {
        let date =  Date()
        let difference = yearsBetweenDates(startDate: date, endDate: Calendar.current.date(byAdding: .day, value: 800, to: date))
        XCTAssert(difference == 2)
    }
    
    func testYearsBetweenDatesSwitcheStartAndEnd() {
        let date =  Date()
        let difference = yearsBetweenDates(startDate: Calendar.current.date(byAdding: .day, value: 1, to: date), endDate: date)
        XCTAssert(difference == 0)
    }
    
    func testYearsBetweenDatesYearsAgo() {
        let date =  Date()
        let difference = yearsBetweenDates(startDate: Calendar.current.date(byAdding: .year, value: -3, to: date), endDate: date)
        XCTAssert(difference == 3)
    }
    
    func testYearsBetweenDatesYearAgoByDays() {
        let date =  Date()
        let difference = yearsBetweenDates(startDate: Calendar.current.date(byAdding: .day, value: -375, to: date), endDate: date)
        XCTAssert(difference == 1)
    }
    
    func testYearsBetweenDatesNils() {
        let date =  Date()
        let difference = yearsBetweenDates(startDate: nil, endDate: date)
        XCTAssert(difference == 0)
    }
    
    func testGetFormattedDate() {
        let date = Date(timeIntervalSince1970: 0)
        let newDateString = getFormattedDate(date: date, format: "MMM d, yyyy", timeZone: TimeZone(abbreviation: "UTC"))
        XCTAssert(newDateString == "Jan 1, 1970")
    }
    
    func testGetFormattedDatePredefinedFormat() {
        let date = Date(timeIntervalSince1970: 0)
        let newDateString = getFormattedDate(date: date, format: DateFormat.yearMonthDayTime, timeZone: TimeZone(abbreviation: "UTC"))
        XCTAssert(newDateString == "1 Jan 1970, 12:00 AM")
    }
    
    func testGetFormattedDateNil() {
        let newDateString = getFormattedDate(date: nil, format: "MMM d, yyyy")
        XCTAssert(newDateString == Constants.invalidDateFormat)
    }
    
}
