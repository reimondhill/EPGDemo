//
//  ReusableIdentifierTests.swift
//  EPGDemoTests
//
//  Created by Ramon Haro Marques on 17/06/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import XCTest
@testable import EPGDemo

class ReusableIdentifierTests: XCTestCase {

    class MyClass: ReusableIdentifier{}
    struct MyStruct: ReusableIdentifier {}
    
    func test_GivenAClass_CheckDefaultReuseIdentifier() {
        XCTAssertEqual(MyClass.defaultReuseIdentifier, "MyClass")
    }
    
    func test_GivenAStruct_CheckDefaultReuseIdentifier() {
        XCTAssertEqual(MyStruct.defaultReuseIdentifier, "MyStruct")
    }

}
