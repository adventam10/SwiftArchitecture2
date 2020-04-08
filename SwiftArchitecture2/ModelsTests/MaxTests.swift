//
//  MaxTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class MaxTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let celsius = "celsius"
        let fahrenheit = "fahrenheit"
        let jsonText = WeatherFactory.makeMaxJSONText(celsius: celsius, fahrenheit: fahrenheit)
        let max = try? JSONDecoder().decode(Max.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(max)
        XCTAssertEqual(max?.celsius, celsius)
        XCTAssertEqual(max?.fahrenheit, fahrenheit)
    }
}

