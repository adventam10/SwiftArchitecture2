//
//  WeatherViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//
import UIKit
import Models
import Views

final class WeatherViewController: UIViewController {
    var model: WeatherModel! {
        didSet {
            registerModel()
        }
    }

    private lazy var myView = WeatherView()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy/MM/dd(E)"
        return formatter
    }()

    deinit {
        model.notificationCenter.removeObserver(self)
    }

    private func registerModel() {
        _ = model.notificationCenter
            .addObserver(forName: .init(rawValue: "weather"),
                         object: nil, queue: nil) { [weak self] notification in
                            if let weather = notification.userInfo?["weather"] as? Weather {
                                self?.updateViews(weather: weather)
                            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refresh(_:)))
        updateViews(weather: model.weather)
    }

    override func loadView() {
        view = myView
    }

    @objc private func refresh(_ sender: Any) {
        showProgress()
        model.requestWeather { [weak self] result in
            self?.hideProgress()
            switch result {
            case .success:
                break
            case .failure(let error):
                self?.showAlert(message: error.localizedDescription)
            }
        }
    }

    private func updateViews(weather: Weather) {
        updateWeatherView(weatherView: myView.todayView,
                          forecast: weather.todayForecast,
                          date: dateFormatter.string(from: Date()))
        updateWeatherView(weatherView: myView.tomorrowView,
                          forecast: weather.tomorrowForecast,
                          date: dateFormatter.string(from: Date(timeIntervalSinceNow: 60 * 60 * 24)))
        updateWeatherView(weatherView: myView.dayAfterTomorrowView,
                          forecast: weather.dayAfterTomorrowForecast,
                          date: dateFormatter.string(from: Date(timeIntervalSinceNow: 60 * 60 * 24 * 2)))
    }

    private func updateWeatherView(weatherView: WeatherInfoView,
                                   forecast: Forecast?,
                                   date: String) {
        weatherView.dateTitleLabel.text = forecast?.dateLabel ?? "-"
        weatherView.dateLabel.text = date

        weatherView.maxCelsiusLabel.text = "最高 " + formattedCelsius(forecast?.maxCelsius)
        weatherView.minCelsiusLabel.text = "最低 " + formattedCelsius(forecast?.minCelsius)

        weatherView.weatherLabel.text = forecast?.telop ?? "-"
        let imageData = forecast?.imageURL.flatMap { try? Data(contentsOf: $0) }
        weatherView.imageView.image = getImage(imageData: imageData)
    }

    private func getImage(imageData: Data?) -> UIImage {
        guard let imageData = imageData,
            let image = UIImage(data: imageData) else {
                return myView.noImage
        }
        return image
    }

    private func formattedCelsius(_ celsius: String?) -> String {
        guard let celsius = celsius,
            !celsius.isEmpty else {
                return "-"
        }
        return "\(celsius)℃"
    }
}
