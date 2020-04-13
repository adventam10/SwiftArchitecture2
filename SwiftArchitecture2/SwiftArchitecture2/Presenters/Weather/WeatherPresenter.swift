//
//  WeatherPresenter.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit
import Models

protocol WeatherModelInput {
    var weather: Weather! { get }
    func requestWeather(_ completion: @escaping (Result<Weather, APIError>) -> Void)
}

protocol WeatherPresenterOutput: AnyObject {
    func showProgress()
    func hideProgress()
    func showAlert(message: String)
    func updateViews(with data: WeatherViewData)
}

extension WeatherModel: WeatherModelInput {
}

final class WeatherPresenter {
    private var model: WeatherModelInput
    private weak var view: WeatherPresenterOutput!

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd(E)"
        return formatter
    }()

    init(view: WeatherPresenterOutput, model: WeatherModelInput) {
        self.view = view
        self.model = model
    }

    // MARK: - Action
    func viewDidLoad() {
        view.updateViews(with: makeWeatherViewData())
    }

    func didTapRefreshButton() {
        self.view.showProgress()
        model.requestWeather { [weak self] result in
            self?.view.hideProgress()
            guard let weakSelf = self else {
                return
            }
            switch result {
            case .success:
                weakSelf.view.updateViews(with: weakSelf.makeWeatherViewData())
            case .failure(let error):
                weakSelf.view.showAlert(message: error.localizedDescription)
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
