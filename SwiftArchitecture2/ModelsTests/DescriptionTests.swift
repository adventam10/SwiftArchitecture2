//
//  DescriptionTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class DescriptionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let text = "text"
        let publicTime = "publicTime"
        let jsonText = WeatherFactory.makeDescriptionJSONText(text: text, publicTime: publicTime)
        let description = try? JSONDecoder().decode(Description.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(description)
        XCTAssertEqual(description?.text, text)
        XCTAssertEqual(description?.publicTime, publicTime)
    }
}

