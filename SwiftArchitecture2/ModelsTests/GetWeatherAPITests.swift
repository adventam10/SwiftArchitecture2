//
//  GetWeatherAPITests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class GetWeatherAPITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_makeRequest() {
        let cityId = "cityId"
        let api = GetWeatherAPI(cityId: cityId)
        let request = api.makeRequest()
        XCTAssertEqual(request.url, URL(string: "http://weather.livedoor.com/forecast/webservice/json/v1?city=\(cityId)")!)
        XCTAssertEqual(request.httpMethod, "GET")
        XCTAssertEqual(request.allHTTPHeaderFields?.count, 1)
        XCTAssertEqual(request.allHTTPHeaderFields?["Accept"], api.accept)
        XCTAssertEqual(request.timeoutInterval, api.timeout)
        XCTAssertNil(request.httpBody)
    }
}

