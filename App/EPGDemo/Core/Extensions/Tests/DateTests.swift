//
//  DateTests.swift
//  EPGDemoTests
//
//  Created by Ramon Haro Marques on 25/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import XCTest
@testable import EPGDemo

class DateTests: XCTestCase {

    func test_DateInit_WhenGivenStringAndLocaleFormat() {
        let dateString = "2020-06-23T00:00:00+00:00"
        let date = Date(string: dateString, using: .locale)
        
        XCTAssertNotNil(date)
        XCTAssertEqual(date?.timeIntervalSince1970, 1592870400)
    }
    
    //TODO toGMTDate
    
    //TODO toLocalDeviceDate
    
//    func test_GivenADate_ThenAssertDateAtMidnight() {
//        let presentEpoch: TimeInterval = 1592917200
//        let presentMidnightEpoch: TimeInterval = 1592870400
//
//        let presentDate = Date(timeIntervalSince1970: presentEpoch)
//        let presentMidnightDate = presentDate.dateAtMidnight
//
//        XCTAssertEqual(presentMidnightDate.toGMTDate.timeIntervalSince1970, presentMidnightEpoch)
//    }
    
    func test_GivenADate_ThenAssertNextDayDate() {
        let presentEpoch: TimeInterval = 1592870400
        let nextDayEpoch: TimeInterval = 1592956800
        
        let presentDate = Date(timeIntervalSince1970: presentEpoch)
        let nextDayDate = presentDate.nextDay
        
        XCTAssertEqual(nextDayDate.timeIntervalSince1970, nextDayEpoch)
    }
    
    func test_GivenTwoDates_ThenAssertDifferenceInSeconds() {
        let startEpoch: TimeInterval = 1592870400
        let endEpoch: TimeInterval = 1592956800
        
        let startDate = Date(timeIntervalSince1970: startEpoch)
        let endDate = Date(timeIntervalSince1970: endEpoch)
        
        var duration = startDate.seconds(from: endDate)
        XCTAssertEqual(duration, 86400)
        
        duration = startDate.seconds(from: nil)
        XCTAssertEqual(duration, 0)
    }
    
    //TODO with

}
