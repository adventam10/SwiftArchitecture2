//
//  WeatherViewModel.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import Models
import ReactiveCocoa
import ReactiveSwift

protocol WeatherModelInput {
    var weather: Weather! { get }
    func requestWeather(_ completion: @escaping (Result<Weather, APIError>) -> Void)
}

extension WeatherModel: WeatherModelInput {
}

final class WeatherViewModel {
    private var model: WeatherModelInput

    private(set) lazy var weatherViewData = Property(mutableWeatherViewData)
    private lazy var mutableWeatherViewData = MutableProperty(self.makeWeatherViewData())
    lazy var refreshButtonAction = Action<Void, Void, APIError> { _ in
        return self.weather()
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd(E)"
        return formatter
    }()

    init(model: WeatherModelInput) {
        self.model = model
    }

    private func weather() -> SignalProducer<Void, APIError> {
        return SignalProducer<Void, APIError> { [weak self] (innerObserver, _) in
            self?.model.requestWeather { result in
                switch result {
                case .success:
                    if let weakSelf = self {
                        weakSelf.mutableWeatherViewData.value = weakSelf.makeWeatherViewData()
                    }
                    innerObserver.send(value: ())
                case .failure(let error):
                    innerObserver.send(error: error)
                }
                innerObserver.sendCompleted()
            }
        }
    }

    // MARK: - Make View Data
    func makeWeatherViewData() -> WeatherViewData {
        let today =
            makeWeatherInfoViewData(with: model.weather.todayForecast,
                                    date: dateFormatter.string(from: Date()))
        let tomorrow =
            makeWeatherInfoViewData(with: model.weather.tomorrowForecast,
                                    date: dateFormatter.string(from: Date(timeIntervalSinceNow: 60 * 60 * 24)))
        let dayAfterTomorrow =
            makeWeatherInfoViewData(with: model.weather.dayAfterTomorrowForecast,
                                    date: dateFormatter.string(from: Date(timeIntervalSinceNow: 60 * 60 * 24 * 2)))
        return .init(today: today, tomorrow: tomorrow, dayAfterTomorrow: dayAfterTomorrow)
    }

    func makeWeatherInfoViewData(with forecast: Forecast?, date: String) -> WeatherInfoViewData {
        let imageData = forecast?.imageURL.flatMap { try? Data(contentsOf: $0) }
        return .init(dateTitle: forecast?.dateLabel ?? "-", date: date,
                     maxCelsius: "最高 " + formattedCelsius(forecast?.maxCelsius),
                     minCelsius: "最低 " + formattedCelsius(forecast?.minCelsius),
                     weather: forecast?.telop ?? "-", imageData: imageData)
    }

    private func formattedCelsius(_ celsius: String?) -> String {
        guard let celsius = celsius,
            !celsius.isEmpty else {
                return "-"
        }
        return "\(celsius)℃"
    }
}
