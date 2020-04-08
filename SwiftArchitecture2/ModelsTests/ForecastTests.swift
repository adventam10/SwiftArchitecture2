//
//  ForecastTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class ForecastTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let date = "date"
        let dateLabel = "dateLabel"
        let telop = "telop"
        let image = WeatherFactory.makeImage()
        let temperature = WeatherFactory.makeTemperature()
        let jsonText = WeatherFactory.makeForecastJSONText(date: date, dateLabel: dateLabel, image: image, telop: telop, temperature: temperature)
        let forecast = try? JSONDecoder().decode(Forecast.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(forecast)
        XCTAssertEqual(forecast?.date, date)
        XCTAssertEqual(forecast?.dateLabel, dateLabel)
        XCTAssertEqual(forecast?.telop, telop)
        XCTAssertEqual(forecast?.image?.url, image.url)
        XCTAssertEqual(forecast?.image?.link, image.link)
        XCTAssertEqual(forecast?.image?.title, image.title)
        XCTAssertEqual(forecast?.image?.height, image.height)
        XCTAssertEqual(forecast?.image?.width, image.width)
        XCTAssertEqual(forecast?.temperature?.max?.celsius, temperature.max?.celsius)
        XCTAssertEqual(forecast?.temperature?.max?.fahrenheit, temperature.max?.fahrenheit)
        XCTAssertEqual(forecast?.temperature?.min?.celsius, temperature.min?.celsius)
        XCTAssertEqual(forecast?.temperature?.min?.fahrenheit, temperature.min?.fahrenheit)
    }
}
