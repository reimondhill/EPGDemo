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
    
    func test_GivenADate_ThenAssertNextDayDate() {
        let presentEpoch: TimeInterval = 1592870400
        let nextDayEpoch: TimeInterval = 1592956800
        
        let presentDate = Date(timeIntervalSince1970: presentEpoch)
        let nextDayDate = presentDate.nextDay
        
        XCTAssertEqual(nextDayDate.timeIntervalSince1970, nextDayEpoch)
    }
    
    func test_GivenTwoDates_WhenSecondIsFuture_ThenAssertDifferenceInSeconds() {
        let startEpoch: TimeInterval = 1592870400
        let endEpoch: TimeInterval =   1592874000
        
        let startDate = Date(timeIntervalSince1970: startEpoch)
        let endDate = Date(timeIntervalSince1970: endEpoch)
        
        var difference = startDate.seconds(from: endDate)
        XCTAssertEqual(difference, 3600)
        
        difference = startDate.seconds(from: nil)
        XCTAssertEqual(difference, 0)
    }
    
    func test_GivenTwoDates_WhenSecondIsPast_ThenAssertDifferenceInSeconds() {
        let startEpoch: TimeInterval = 1592870400
        let endEpoch: TimeInterval =   1592866800
        
        let startDate = Date(timeIntervalSince1970: startEpoch)
        let endDate = Date(timeIntervalSince1970: endEpoch)
        
        var difference = startDate.seconds(from: endDate)
        XCTAssertEqual(difference, -3600)
        
        difference = startDate.seconds(from: nil)
        XCTAssertEqual(difference, 0)
    }
    
    func test_GivenDateNoSeconds24HoursFormat_ThenAssertTime() {
        let gmtTimeZone = TimeZone(secondsFromGMT: 0)!
        TimeZone.ReferenceType.default = gmtTimeZone
        
        let timeEpochMorning: TimeInterval = 1592910030
        let dateMorning = Date(timeIntervalSince1970: timeEpochMorning)
        XCTAssertEqual(dateMorning.timeString(shouldShowSeconds: false, twentyFourHourFormat: true, shouldShowSymbol: true), "11:00")
        XCTAssertEqual(dateMorning.timeString(shouldShowSeconds: true, twentyFourHourFormat: true, shouldShowSymbol: true), "11:00:30")
        
        let timeEpochNight: TimeInterval = 1592953230
        let dateNight = Date(timeIntervalSince1970: timeEpochNight)
        XCTAssertEqual(dateNight.timeString(shouldShowSeconds: false, twentyFourHourFormat: true, shouldShowSymbol: true), "23:00")
        XCTAssertEqual(dateNight.timeString(shouldShowSeconds: true, twentyFourHourFormat: true, shouldShowSymbol: true), "23:00:30")
    }
    
    func test_GivenDateNoSecondsNot24HoursFormat_ThenAssertTime() {
        let gmtTimeZone = TimeZone(secondsFromGMT: 0)!
        TimeZone.ReferenceType.default = gmtTimeZone
        
        let timeEpochMorning: TimeInterval = 1592910030
        let dateMorning = Date(timeIntervalSince1970: timeEpochMorning)
        XCTAssertEqual(dateMorning.timeString(shouldShowSeconds: false, twentyFourHourFormat: false, shouldShowSymbol: false), "11:00")
        XCTAssertEqual(dateMorning.timeString(shouldShowSeconds: true, twentyFourHourFormat: false, shouldShowSymbol: true), "11:00:30 AM")
        
        let timeEpochNight: TimeInterval = 1592953230
        let dateNight = Date(timeIntervalSince1970: timeEpochNight)
        XCTAssertEqual(dateNight.timeString(shouldShowSeconds: false, twentyFourHourFormat: false, shouldShowSymbol: false), "11:00")
        XCTAssertEqual(dateNight.timeString(shouldShowSeconds: true, twentyFourHourFormat: false, shouldShowSymbol: true), "11:00:30 PM")
    }
    
    //TODO with

}
