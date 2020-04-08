//
//  LocationTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class LocationTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let area = "area"
        let city = "city"
        let prefecture = "prefecture"
        let jsonText = WeatherFactory.makeLocationJSONText(area: area, city: city, prefecture: prefecture)
        let location = try? JSONDecoder().decode(Location.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(location)
        XCTAssertEqual(location?.area, area)
        XCTAssertEqual(location?.city, city)
        XCTAssertEqual(location?.prefecture, prefecture)
    }
}

