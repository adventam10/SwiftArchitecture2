//
//  CopyrightTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class CopyrightTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let link = "link"
        let title = "title"
        let image = WeatherFactory.makeImage()
        let provider = WeatherFactory.makeProvider()
        let jsonText = WeatherFactory.makeCopyrightJSONText(link: link, title: title, image: image, provider: provider)
        let copyright = try? JSONDecoder().decode(Copyright.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(copyright)
        XCTAssertEqual(copyright?.link, link)
        XCTAssertEqual(copyright?.title, title)
        XCTAssertEqual(copyright?.image?.url, image.url)
        XCTAssertEqual(copyright?.image?.link, image.link)
        XCTAssertEqual(copyright?.image?.title, image.title)
        XCTAssertEqual(copyright?.image?.height, image.height)
        XCTAssertEqual(copyright?.image?.width, image.width)
        XCTAssertEqual(copyright?.provider?.first?.link, provider.link)
        XCTAssertEqual(copyright?.provider?.first?.name, provider.name)
    }
}
