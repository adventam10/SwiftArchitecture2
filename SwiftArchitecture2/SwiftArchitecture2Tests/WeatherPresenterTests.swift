//
//  WeatherPresenterTests.swift
//  SwiftArchitecture2Tests
//
//  Created by am10 on 2020/04/13.
//  Copyright © 2020 am10. All rights reserved.
//

import XCTest
@testable import SwiftArchitecture2
@testable import Models

//final class WeatherPresenterTests: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func test_makeWeatherViewData_when_forecasts_nil() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        model.weather = makeWeather(forecasts: nil)
//        let presenter = WeatherPresenter(view: view, model: model)
//        let data = presenter.makeWeatherViewData()
//        XCTAssertNotNil(data.today)
//        XCTAssertNotNil(data.tomorrow)
//        XCTAssertNotNil(data.dayAfterTomorrow)
//    }
//
//    func test_makeWeatherViewData_when_forecasts_empty() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        model.weather = makeWeather(forecasts: [])
//        let presenter = WeatherPresenter(view: view, model: model)
//        let data = presenter.makeWeatherViewData()
//        XCTAssertNotNil(data.today)
//        XCTAssertNotNil(data.tomorrow)
//        XCTAssertNotNil(data.dayAfterTomorrow)
//    }
//
//    func test_makeWeatherViewData_when_forecasts_have_three_elements() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let forecast = makeForecast(dateLabel: "", telop: "")
//        model.weather = makeWeather(forecasts: [forecast, forecast, forecast])
//        let presenter = WeatherPresenter(view: view, model: model)
//        let data = presenter.makeWeatherViewData()
//        XCTAssertNotNil(data.today)
//        XCTAssertNotNil(data.tomorrow)
//        XCTAssertNotNil(data.dayAfterTomorrow)
//    }
//
//    func test_makeWeatherViewData_when_forecasts_have_two_elements() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let forecast = makeForecast(dateLabel: "", telop: "")
//        model.weather = makeWeather(forecasts: [forecast, forecast])
//        let presenter = WeatherPresenter(view: view, model: model)
//        let data = presenter.makeWeatherViewData()
//        XCTAssertNotNil(data.today)
//        XCTAssertNotNil(data.tomorrow)
//        XCTAssertNotNil(data.dayAfterTomorrow)
//    }
//
//    func test_makeWeatherViewData_when_forecasts_have_one_element() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let forecast = makeForecast(dateLabel: "", telop: "")
//        model.weather = makeWeather(forecasts: [forecast])
//        let presenter = WeatherPresenter(view: view, model: model)
//        let data = presenter.makeWeatherViewData()
//        XCTAssertNotNil(data.today)
//        XCTAssertNotNil(data.tomorrow)
//        XCTAssertNotNil(data.dayAfterTomorrow)
//    }
//
//    func test_makeWeatherInfoViewData_when_forecast_nil() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let date = "date"
//        let data = presenter.makeWeatherInfoViewData(with: nil, date: date)
//        XCTAssertEqual(data.date, date)
//        XCTAssertEqual(data.dateTitle, "-")
//        XCTAssertEqual(data.weather, "-")
//        XCTAssertEqual(data.maxCelsius, "最高 -")
//        XCTAssertEqual(data.minCelsius, "最低 -")
//        XCTAssertNil(data.imageData)
//    }
//
//    func test_makeWeatherInfoViewData_dateTitle_when_forecast_dateLabel_not_nil() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let dateLabel = "dateLabel"
//        let forecast = makeForecast(dateLabel: dateLabel, telop: "")
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.dateTitle, dateLabel)
//    }
//
//    func test_makeWeatherInfoViewData_weather_when_forecast_telop_not_nil() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let telop = "telop"
//        let forecast = makeForecast(dateLabel: "", telop: telop)
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.weather, telop)
//    }
//
//    func test_makeWeatherInfoViewData_imageData_when_forecast_image_url_empty() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "", image: makeImage(url: ""))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertNil(data.imageData)
//    }
//
//    func test_makeWeatherInfoViewData_imageData_when_forecast_image_url_not_empty() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "", image: makeImage(url: "https://example.com"))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertNotNil(data.imageData)
//    }
//
//    func test_makeWeatherInfoViewData_maxCelsius_when_forecast_temperature_max_nil() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "",
//                                    temperature: .init(max: nil, min: nil))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.maxCelsius, "最高 -")
//    }
//
//    func test_makeWeatherInfoViewData_maxCelsius_when_forecast_temperature_max_celsius_empty() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "",
//                                    temperature: makeTemperature(maxCelsius: ""))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.maxCelsius, "最高 -")
//    }
//
//    func test_makeWeatherInfoViewData_maxCelsius_when_forecast_temperature_max_celsius_not_empty() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "",
//                                    temperature: makeTemperature(maxCelsius: "20"))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.maxCelsius, "最高 20℃")
//    }
//
//    func test_makeWeatherInfoViewData_minCelsius_when_forecast_temperature_min_nil() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "",
//                                    temperature: .init(max: nil, min: nil))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.minCelsius, "最低 -")
//    }
//
//    func test_makeWeatherInfoViewData_minCelsius_when_forecast_temperature_min_celsius_empty() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "",
//                                    temperature: makeTemperature(minCelsius: ""))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.minCelsius, "最低 -")
//    }
//
//    func test_makeWeatherInfoViewData_minCelsius_when_forecast_temperature_min_celsius_not_empty() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        let forecast = makeForecast(dateLabel: "", telop: "",
//                                    temperature: makeTemperature(minCelsius: "20"))
//        let data = presenter.makeWeatherInfoViewData(with: forecast, date: "")
//        XCTAssertEqual(data.minCelsius, "最低 20℃")
//    }
//
//    private func makeWeather(forecasts: [Forecast]?) -> Weather {
//        return .init(copyright: nil,
//                     descriptionField: nil,
//                     forecasts: forecasts,
//                     link: "",
//                     location: nil,
//                     pinpointLocations: nil,
//                     publicTime: "",
//                     title: "")
//    }
//
//    private func makeForecast(dateLabel: String, telop: String,
//                              image: Image? = nil,
//                              temperature: Temperature? = nil) -> Forecast {
//        return .init(date: "", dateLabel: dateLabel,
//                     image: image, telop: telop, temperature: temperature)
//    }
//
//    private func makeImage(url: String) -> Image {
//        return .init(height: 0, link: "", title: "", url: url, width: 0)
//    }
//
//    private func makeTemperature(maxCelsius: String = "",
//                                 minCelsius: String = "") -> Temperature {
//        return .init(max: .init(celsius: maxCelsius, fahrenheit: ""),
//                     min: .init(celsius: minCelsius, fahrenheit: ""))
//    }
//
//    func test_viewDidLoad() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        let presenter = WeatherPresenter(view: view, model: model)
//        XCTContext.runActivity(named: "画面表示時の処理") { _ in
//            presenter.viewDidLoad()
//            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callUpdateViewsCount, 1)
//            }
//        }
//    }
//
//    func test_didTapRefreshButton_isSuccess() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        model.isRequestSuccess = true
//        let presenter = WeatherPresenter(view: view, model: model)
//        XCTContext.runActivity(named: "リフレッシュボタン押下時の処理") { _ in
//            presenter.didTapRefreshButton()
//            XCTContext.runActivity(named: "プログレスの表示処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callShowProgressCount, 1)
//            }
//            XCTContext.runActivity(named: "天気の取得処理が呼ばれること") { _ in
//                XCTAssertEqual(model.callRequestWeatherCount, 1)
//            }
//            XCTContext.runActivity(named: "プログレスの非表示処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callHideProgressCount, 1)
//            }
//            XCTContext.runActivity(named: "画面の更新処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callUpdateViewsCount, 1)
//            }
//            XCTContext.runActivity(named: "アラートの表示処理が呼ばれないこと") { _ in
//                XCTAssertEqual(view.callShowAlertCount, 0)
//            }
//        }
//    }
//
//    func test_didTapRefreshButton_isFailure() {
//        let view = WeatherViewSpy()
//        let model = WeatherModelSpy()
//        model.isRequestSuccess = false
//        let presenter = WeatherPresenter(view: view, model: model)
//        XCTContext.runActivity(named: "リフレッシュボタン押下時の処理") { _ in
//            presenter.didTapRefreshButton()
//            XCTContext.runActivity(named: "プログレスの表示処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callShowProgressCount, 1)
//            }
//            XCTContext.runActivity(named: "天気の取得処理が呼ばれること") { _ in
//                XCTAssertEqual(model.callRequestWeatherCount, 1)
//            }
//            XCTContext.runActivity(named: "プログレスの非表示処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callHideProgressCount, 1)
//            }
//            XCTContext.runActivity(named: "画面の更新処理が呼ばれないこと") { _ in
//                XCTAssertEqual(view.callUpdateViewsCount, 0)
//            }
//            XCTContext.runActivity(named: "アラートの表示処理が呼ばれること") { _ in
//                XCTAssertEqual(view.callShowAlertCount, 1)
//            }
//        }
//    }
//}
//
//private final class WeatherViewSpy: WeatherPresenterOutput {
//    var callUpdateViewsCount: Int = 0
//    var callShowProgressCount: Int = 0
//    var callHideProgressCount: Int = 0
//    var callShowAlertCount: Int = 0
//
//    func showProgress() {
//        callShowProgressCount += 1
//    }
//
//    func hideProgress() {
//        callHideProgressCount += 1
//    }
//
//    func showAlert(message: String) {
//        callShowAlertCount += 1
//    }
//
//    func updateViews(with data: WeatherViewData) {
//        callUpdateViewsCount += 1
//    }
//}
//
//private final class WeatherModelSpy: WeatherModelInput {
//    var weather: Weather! = .init(copyright: nil,
//                                  descriptionField: nil,
//                                  forecasts: nil,
//                                  link: "",
//                                  location: nil,
//                                  pinpointLocations: nil,
//                                  publicTime: "",
//                                  title: "")
//    var callRequestWeatherCount: Int = 0
//    var isRequestSuccess = true
//
//    func requestWeather(_ completion: @escaping (Result<Weather, APIError>) -> Void) {
//        callRequestWeatherCount += 1
//        if isRequestSuccess {
//            completion(.success(.init(copyright: nil,
//                                      descriptionField: nil,
//                                      forecasts: nil,
//                                      link: "",
//                                      location: nil,
//                                      pinpointLocations: nil,
//                                      publicTime: "",
//                                      title: "")))
//        } else {
//            completion(.failure(.network))
//        }
//    }
//}
