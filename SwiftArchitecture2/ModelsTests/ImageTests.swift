//
//  ImageTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class ImageTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let url = "url"
        let title = "title"
        let height = 12
        let width = 13
        let jsonText = WeatherFactory.makeImageJSONText(url: url, title: title, height: height, width: width)
        let image = try? JSONDecoder().decode(Image.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(image)
        XCTAssertEqual(image?.url, url)
        XCTAssertEqual(image?.title, title)
        XCTAssertEqual(image?.height, height)
        XCTAssertEqual(image?.width, width)
    }
}
