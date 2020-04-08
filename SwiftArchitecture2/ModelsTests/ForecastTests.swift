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
        let image = makeImage()
        let temperature = makeTemperature()
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

extension ForecastTests {
    private func makeImage() -> Image {
        let jsonText = WeatherFactory.makeImageJSONText(link:"link", url: "url", title: "title", height: 11, width: 13)
        return try! JSONDecoder().decode(Image.self, from: jsonText.data(using: .utf8)!)
    }
    
    private func makeTemperature() -> Temperature {
        let jsonText = WeatherFactory.makeTemperatureJSONText(max: makeMax(), min: makeMin())
        return try! JSONDecoder().decode(Temperature.self, from: jsonText.data(using: .utf8)!)
    }

    private func makeMin() -> Max {
        let jsonText = WeatherFactory.makeMaxJSONText(celsius: "celsiusMin", fahrenheit: "fahrenheitMin")
        return try! JSONDecoder().decode(Max.self, from: jsonText.data(using: .utf8)!)
    }

    private func makeMax() -> Max {
        let jsonText = WeatherFactory.makeMaxJSONText(celsius: "celsiusMax", fahrenheit: "fahrenheitMax")
        return try! JSONDecoder().decode(Max.self, from: jsonText.data(using: .utf8)!)
    }
}
