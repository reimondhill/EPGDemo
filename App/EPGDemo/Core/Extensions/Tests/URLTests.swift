//
//  URLTests.swift
//  EPGDemoTests
//
//  Created by Ramon Haro Marques on 24/05/2020.
//  Copyright © 2020 Ramon Haro Marques. All rights reserved.
//

import XCTest
@testable import EPGDemo

class URLTests: XCTestCase {

    func testGivenParamsThenURLContainsParams() {
        let params = ["id":"1",
                      "name":"foo"]
        
        let baseURL = "https://myserver.com:8888"
        let url = URL(string: baseURL)?.appending(params: params)
        XCTAssertTrue((url?.absoluteString == "\(baseURL)?id=1&name=foo") || (url?.absoluteString == "\(baseURL)?name=foo&id=1"))
    }

}
