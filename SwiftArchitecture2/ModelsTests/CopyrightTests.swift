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
        let image = makeImage()
        let provider = makeProvider()
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

extension CopyrightTests {
    private func makeImage() -> Image {
        let jsonText = WeatherFactory.makeImageJSONText(link:"link", url: "url", title: "title", height: 11, width: 13)
        return try! JSONDecoder().decode(Image.self, from: jsonText.data(using: .utf8)!)
    }

    private func makeProvider() -> Provider {
        let jsonText = WeatherFactory.makeProviderJSONText(link: "link", name: "name")
        return try! JSONDecoder().decode(Provider.self, from: jsonText.data(using: .utf8)!)
    }
}
