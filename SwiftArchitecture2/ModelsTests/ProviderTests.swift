//
//  ProviderTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class ProviderTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let link = "link"
        let name = "name"
        let jsonText = WeatherFactory.makeProviderJSONText(link: link, name: name)
        let provider = try? JSONDecoder().decode(Provider.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(provider)
        XCTAssertEqual(provider?.link, link)
        XCTAssertEqual(provider?.name, name)
    }
}
