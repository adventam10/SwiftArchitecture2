//
//  CityDataTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class CityDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let area = 1
        let cityId = "cityId"
        let name = "name"
        let text = """
        { "area": \(area), "cityId": "\(cityId)", "name": "\(name)" }
        """
        let cityData = try? JSONDecoder().decode(CityData.self, from: text.data(using: .utf8)!)
        XCTAssertNotNil(cityData)
        XCTAssertEqual(cityData?.area, area)
        XCTAssertEqual(cityData?.cityId, cityId)
        XCTAssertEqual(cityData?.name, name)
    }
}
