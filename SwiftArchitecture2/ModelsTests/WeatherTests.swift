//
//  WeatherTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class WeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_JSON_parse() {
        let link = "link"
        let title = "title"
        let publicTime = "publicTime"
        let copyright = WeatherFactory.makeCopyright()
        let description = WeatherFactory.makeDescription()
        let location = WeatherFactory.makeLocation()
        let pinpointLocation = WeatherFactory.makeProvider()
        let forecast = WeatherFactory.makeForecast()
        let jsonText = WeatherFactory.makeWeatherJSONText(link: link, title: title, copyright: copyright, descriptionField: description, publicTime: publicTime, location: location, forecast: forecast, pinpointLocation: pinpointLocation)
        let weather = try? JSONDecoder().decode(Weather.self, from: jsonText.data(using: .utf8)!)
        XCTAssertNotNil(weather)
        XCTAssertEqual(weather?.link, link)
        XCTAssertEqual(weather?.title, title)
        XCTAssertEqual(weather?.publicTime, publicTime)
        
        XCTAssertEqual(weather?.copyright?.link, copyright.link)
        XCTAssertEqual(weather?.copyright?.title, copyright.title)
        XCTAssertEqual(weather?.copyright?.image?.url, copyright.image?.url)
        XCTAssertEqual(weather?.copyright?.image?.link, copyright.image?.link)
        XCTAssertEqual(weather?.copyright?.image?.title, copyright.image?.title)
        XCTAssertEqual(weather?.copyright?.image?.height, copyright.image?.height)
        XCTAssertEqual(weather?.copyright?.image?.width, copyright.image?.width)
        XCTAssertEqual(weather?.copyright?.provider?.first?.link, copyright.provider?.first?.link)
        XCTAssertEqual(weather?.copyright?.provider?.first?.name, copyright.provider?.first?.name)

        XCTAssertEqual(weather?.descriptionField?.text, description.text)
        XCTAssertEqual(weather?.descriptionField?.publicTime, description.publicTime)

        XCTAssertEqual(weather?.location?.area, location.area)
        XCTAssertEqual(weather?.location?.city, location.city)
        XCTAssertEqual(weather?.location?.prefecture, location.prefecture)

        XCTAssertEqual(weather?.pinpointLocations?.first?.link, pinpointLocation.link)
        XCTAssertEqual(weather?.pinpointLocations?.first?.name, pinpointLocation.name)
        
        XCTAssertEqual(weather?.forecasts?.first?.date, forecast.date)
        XCTAssertEqual(weather?.forecasts?.first?.dateLabel, forecast.dateLabel)
        XCTAssertEqual(weather?.forecasts?.first?.telop, forecast.telop)
        XCTAssertEqual(weather?.forecasts?.first?.image?.url, forecast.image?.url)
        XCTAssertEqual(weather?.forecasts?.first?.image?.link, forecast.image?.link)
        XCTAssertEqual(weather?.forecasts?.first?.image?.title, forecast.image?.title)
        XCTAssertEqual(weather?.forecasts?.first?.image?.height, forecast.image?.height)
        XCTAssertEqual(weather?.forecasts?.first?.image?.width, forecast.image?.width)
        XCTAssertEqual(weather?.forecasts?.first?.temperature?.max?.celsius, forecast.temperature?.max?.celsius)
        XCTAssertEqual(weather?.forecasts?.first?.temperature?.max?.fahrenheit, forecast.temperature?.max?.fahrenheit)
        XCTAssertEqual(weather?.forecasts?.first?.temperature?.min?.celsius, forecast.temperature?.min?.celsius)
        XCTAssertEqual(weather?.forecasts?.first?.temperature?.min?.fahrenheit, forecast.temperature?.min?.fahrenheit)
    }
}
