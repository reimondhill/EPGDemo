//
//  LoggerTests.swift
//  EPGDemoTests
//
//  Created by Ramon Haro Marques on 16/06/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import XCTest
@testable import EPGDemo

class LoggerTests: XCTestCase {

    func test_WhenLogDebug_ThenAssumeCorrectPrint() {
        XCTAssertEqual(Logger.d(message: "I am a debug test"), "🟢 LoggerTests.swift -> LINE: \(#line) -> test_WhenLogDebug_ThenAssumeCorrectPrint() => I am a debug test")
        
    }

    func test_WhenLogWarning_ThenAssumeCorrectPrint() {
        XCTAssertEqual(Logger.w(message: "I am a warning test"), "🟡 LoggerTests.swift -> LINE: \(#line) -> test_WhenLogWarning_ThenAssumeCorrectPrint() => I am a warning test")
        
    }
    
    func test_WhenLogError_ThenAssumeCorrectPrint() {
        XCTAssertEqual(Logger.e(message: "I am an error test"), "🔴 LoggerTests.swift -> LINE: \(#line) -> test_WhenLogError_ThenAssumeCorrectPrint() => I am an error test")
        
    }

}
