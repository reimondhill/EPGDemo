//
//  CollectionTest.swift
//  EPGDemoTests
//
//  Created by Ramon Haro Marques on 23/06/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import XCTest
@testable import EPGDemo

class CollectionTest: XCTestCase {

    var numbers = ["One", "Two", "Three"]
    
    func test_GivenArray_CheckSafeElementInRangeExist() {
        XCTAssertEqual(numbers[safe: 0], "One")
    }

    func test_GivenArray_CheckSafeElementNotInRangeIsNil() {
        XCTAssertEqual(numbers[safe: 3], nil)
    }
    
}
