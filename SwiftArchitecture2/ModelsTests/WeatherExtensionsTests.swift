//
//  WeatherExtensionsTests.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import Models

final class WeatherExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_todayForecast_when_count_0() {
        let weather = WeatherFactory.makeWeather(forecasts: [])
        XCTAssertNil(weather?.todayForecast)
    }

    func test_todayForecast_when_count_1() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast])
        XCTAssertNotNil(weather?.todayForecast)
    }

    func test_todayForecast_when_count_2() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast, forecast])
        XCTAssertNotNil(weather?.todayForecast)
    }

    func test_todayForecast_when_count_3() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast, forecast, forecast])
        XCTAssertNotNil(weather?.todayForecast)
    }

    func test_tomorrowForecast_when_count_0() {
        let weather = WeatherFactory.makeWeather(forecasts: [])
        XCTAssertNil(weather?.tomorrowForecast)
    }

    func test_tomorrowForecast_when_count_1() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast])
        XCTAssertNil(weather?.tomorrowForecast)
    }

    func test_tomorrowForecast_when_count_2() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast, forecast])
        XCTAssertNotNil(weather?.tomorrowForecast)
    }

    func test_tomorrowForecast_when_count_3() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast, forecast, forecast])
        XCTAssertNotNil(weather?.tomorrowForecast)
    }
    
    func test_dayAfterTomorrowForecast_when_count_0() {
        let weather = WeatherFactory.makeWeather(forecasts: [])
        XCTAssertNil(weather?.dayAfterTomorrowForecast)
    }

    func test_dayAfterTomorrowForecast_when_count_1() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast])
        XCTAssertNil(weather?.dayAfterTomorrowForecast)
    }

    func test_dayAfterTomorrowForecast_when_count_2() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast, forecast])
        XCTAssertNil(weather?.dayAfterTomorrowForecast)
    }

    func test_dayAfterTomorrowForecast_when_count_3() {
        let forecast = WeatherFactory.makeForecast()
        let weather = WeatherFactory.makeWeather(forecasts: [forecast, forecast, forecast])
        XCTAssertNotNil(weather?.dayAfterTomorrowForecast)
    }
    
    func test_maxCelsius() {
        let celsius = "celsius"
        let max = WeatherFactory.makeMax(celsius: celsius)
        print(max.celsius)
        let temperature = WeatherFactory.makeTemperature(max: max)
        let forecast = WeatherFactory.makeForecast(temperature: temperature)
        XCTAssertEqual(forecast.maxCelsius, celsius)
    }

    func test_maxCelsius_when_temperature_nil() {
        let forecast = WeatherFactory.makeForecast(temperature: nil)
        XCTAssertTrue(forecast.maxCelsius.isEmpty)
    }

    func test_maxCelsius_when_max_nil() {
        let temperature = WeatherFactory.makeTemperature(max: nil)
        let forecast = WeatherFactory.makeForecast(temperature: temperature)
        XCTAssertTrue(forecast.maxCelsius.isEmpty)
    }

    func test_maxCelsius_when_max_celsius_empty() {
        let celsius = ""
        let max = WeatherFactory.makeMax(celsius: celsius)
        let temperature = WeatherFactory.makeTemperature(max: max)
        let forecast = WeatherFactory.makeForecast(temperature: temperature)
        XCTAssertTrue(forecast.maxCelsius.isEmpty)
    }
    
    func test_minCelsius() {
        let celsius = "celsius"
        let min = WeatherFactory.makeMax(celsius: celsius)
        let temperature = WeatherFactory.makeTemperature(min: min)
        let forecast = WeatherFactory.makeForecast(temperature: temperature)
        XCTAssertEqual(forecast.minCelsius, celsius)
    }

    func test_minCelsius_when_temperature_nil() {
        let forecast = WeatherFactory.makeForecast(temperature: nil)
        XCTAssertTrue(forecast.minCelsius.isEmpty)
    }

    func test_minCelsius_when_min_nil() {
        let temperature = WeatherFactory.makeTemperature(min: nil)
        let forecast = WeatherFactory.makeForecast(temperature: temperature)
        XCTAssertTrue(forecast.minCelsius.isEmpty)
    }

    func test_minCelsius_when_min_celsius_empty() {
        let celsius = ""
        let min = WeatherFactory.makeMax(celsius: celsius)
        let temperature = WeatherFactory.makeTemperature(min: min)
        let forecast = WeatherFactory.makeForecast(temperature: temperature)
        XCTAssertTrue(forecast.minCelsius.isEmpty)
    }

    func test_imageURL() {
        let image = WeatherFactory.makeImage(url: "https://example.com")
        let forecast = WeatherFactory.makeForecast(image: image)
        XCTAssertNotNil(forecast.imageURL)
    }

    func test_imageURL_when_image_nil() {
        let forecast = WeatherFactory.makeForecast(image: nil)
        XCTAssertNil(forecast.imageURL)
    }
}

