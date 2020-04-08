//
//  TemperatureTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class TemperatureTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let min = WeatherFactory.makeMin()
        let max = WeatherFactory.makeMax()
        let jsonText = WeatherFactory.makeTemperatureJSONText(max: max, min: min)
        let temperature = try? JSONDecoder().decode(Temperature.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(temperature)
        XCTAssertEqual(temperature?.max?.celsius, max.celsius)
        XCTAssertEqual(temperature?.max?.fahrenheit, max.fahrenheit)
        XCTAssertEqual(temperature?.min?.celsius, min.celsius)
        XCTAssertEqual(temperature?.min?.fahrenheit, min.fahrenheit)
    }
}
