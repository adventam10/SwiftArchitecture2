//
//  WeatherViewController.swift
//  SwiftArchitecture2
//
//  Created by am10 on 2020/04/08.
//Copyright © 2020 am10. All rights reserved.
//

import UIKit

final class WeatherViewController: UIViewController {

    enum ItemTag: Int {
        case minCelsiusLabel = 1
        case maxCelsiusLabel = 2
        case weatherLabel = 3
        case imageView = 4
        case dateLabel = 5
        case dateTitleLabel = 6
    }

    var cityId = ""
    var weather: [String: Any?] = [:]

    private let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 16
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let subStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let dateFormatter: DateFormatter = {
        var df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.dateFormat = "yyyy/MM/dd(E)"
        return df
    }()
    private var todayView: UIView!
    private var tomorrowView: UIView!
    private var dayAfterTomorrowView: UIView!

    private let progressView: UIView = {
        let progress = UIView()
        progress.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()

    private let indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .whiteLarge
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "お天気"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh,
                                                            target: self,
                                                            action: #selector(refresh(_:)))

        todayView = makeWeatherView()
        tomorrowView = makeWeatherView()
        dayAfterTomorrowView = makeWeatherView()

        addSubViews()
        setupLayout()
        
        updateViews(weather: weather)
    }

    // MARK: - Setup Views
    private func addSubViews() {
        progressView.addSubview(indicatorView)
        
        subStackView.addArrangedSubview(tomorrowView)
        subStackView.addArrangedSubview(dayAfterTomorrowView)
        mainStackView.addArrangedSubview(todayView)
        mainStackView.addArrangedSubview(subStackView)
        view.addSubview(mainStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            subStackView.heightAnchor.constraint(equalTo: todayView.heightAnchor, multiplier: 0.8)
        ])

        NSLayoutConstraint.activate([
            indicatorView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor, constant: 0),
            indicatorView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor, constant: 0)
        ])
    }

    private func makeWeatherView() -> UIView {
        let mainStackView = { () -> UIStackView in
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .center
            stack.distribution = .fill
            stack.spacing = 8
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()

        let dateTitleLabel = { () -> UILabel in
            let label = UILabel()
            label.textAlignment = .center
            label.tag = ItemTag.dateTitleLabel.rawValue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let dateLabel = { () -> UILabel in
            let label = UILabel()
            label.textAlignment = .center
            label.tag = ItemTag.dateLabel.rawValue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let headerStackView = { () -> UIStackView in
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 4
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        headerStackView.addArrangedSubview(dateTitleLabel)
        headerStackView.addArrangedSubview(dateLabel)

        let imageView = { () -> UIImageView in
            let image = UIImageView()
            image.tag = ItemTag.imageView.rawValue
            image.translatesAutoresizingMaskIntoConstraints = false
            return image
        }()

        let weatherLabel = { () -> UILabel in
            let label = UILabel()
            label.textAlignment = .center
            label.tag = ItemTag.weatherLabel.rawValue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let minCelsiusLabel = { () -> UILabel in
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .blue
            label.tag = ItemTag.minCelsiusLabel.rawValue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let maxCelsiusLabel = { () -> UILabel in
            let label = UILabel()
            label.textAlignment = .center
            label.textColor = .red
            label.tag = ItemTag.maxCelsiusLabel.rawValue
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let celsiusStackView = { () -> UIStackView in
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 4
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        celsiusStackView.addArrangedSubview(minCelsiusLabel)
        celsiusStackView.addArrangedSubview(maxCelsiusLabel)

        mainStackView.addArrangedSubview(headerStackView)
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(weatherLabel)
        mainStackView.addArrangedSubview(celsiusStackView)
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0).isActive = true
        dateLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        dateTitleLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        maxCelsiusLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        minCelsiusLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        weatherLabel.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return mainStackView
    }

    // MARK: - Action
    @objc private func refresh(_ sender: Any) {
        showProgress()
        requestWeather(cityId: cityId) { [weak self] result in
            DispatchQueue.main.async {
                self?.hideProgress()
                switch result {
                case .success(let weather):
                    self?.weather = weather
                    self?.updateViews(weather: weather)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Show
    private func showProgress() {
        indicatorView.startAnimating()
        navigationController?.view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: progressView.superview!.topAnchor, constant: 0),
            progressView.bottomAnchor.constraint(equalTo: progressView.superview!.bottomAnchor, constant: 0),
            progressView.leadingAnchor.constraint(equalTo: progressView.superview!.leadingAnchor, constant: 0),
            progressView.trailingAnchor.constraint(equalTo: progressView.superview!.trailingAnchor, constant: 0)
        ])
    }

    private func hideProgress() {
        indicatorView.stopAnimating()
        progressView.removeFromSuperview()
    }

    private func showAlert(title: String = "",
                   message: String,
                   buttonTitle: String = "OK",
                   buttonAction: @escaping (() -> Void) = {}) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: buttonTitle,
                                          style: .default,
                                          handler:
            {
                (action: UIAlertAction!) -> Void in
                buttonAction()
        })
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Request
    private func requestWeather(cityId: String, completion: @escaping (Result<[String: Any?], APIError>) -> Void) {
        let session = URLSession.shared
        let url = BASE_URL + "?city=\(cityId)"
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let _ = error {
                completion(.failure(.network))
                return
            }

            if (response as? HTTPURLResponse)?.statusCode != 200 {
                completion(.failure(.server))
                return
            }
            guard let data = data,
                let result = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any?] else {
                    completion(.failure(.invalidJSON))
                    return
            }
            completion(.success(result))
        }
        task.resume()
    }

    // MARK: - Update Views
    private func updateViews(weather: [String: Any?]) {
        let forecasts = weather["forecasts"] as? [[String: Any?]]
        updateWeatherView(weatherView: todayView,
                          forecast: forecasts?.first,
                          date: dateFormatter.string(from: Date()))
        updateWeatherView(weatherView: tomorrowView,
                          forecast: forecasts?.count ?? 0 > 1 ? forecasts?[1] : nil,
                          date: dateFormatter.string(from: Date(timeIntervalSinceNow: 60*60*24)))
        updateWeatherView(weatherView: dayAfterTomorrowView,
                          forecast: forecasts?.count ?? 0 > 2 ? forecasts?[2] : nil,
                          date: dateFormatter.string(from: Date(timeIntervalSinceNow: 60*60*24*2)))
    }

    private func updateWeatherView(weatherView: UIView,
                                   forecast: [String: Any?]?,
                                   date: String) {
        let dateTitleLabel = weatherView.viewWithTag(ItemTag.dateTitleLabel.rawValue) as? UILabel
        let dateLabel = weatherView.viewWithTag(ItemTag.dateLabel.rawValue) as? UILabel
        let maxCelsiusLabel = weatherView.viewWithTag(ItemTag.maxCelsiusLabel.rawValue) as? UILabel
        let minCelsiusLabel = weatherView.viewWithTag(ItemTag.minCelsiusLabel.rawValue) as? UILabel
        let weatherLabel = weatherView.viewWithTag(ItemTag.weatherLabel.rawValue) as? UILabel
        let imageView = weatherView.viewWithTag(ItemTag.imageView.rawValue) as? UIImageView

        dateTitleLabel?.text = forecast?["dateLabel"] as? String ?? "-"
        dateLabel?.text = date

        let maxCelsius = forecast.flatMap { $0["temperature"] as? [String: Any?] }
            .flatMap { $0["max"]  as? [String: Any?] }
            .flatMap { $0["celsius"] as? String }
        maxCelsiusLabel?.text = "最高 " + formattedCelsius(maxCelsius)
        let minCelsius = forecast.flatMap { $0["temperature"] as? [String: Any?] }
            .flatMap { $0["min"]  as? [String: Any?] }
            .flatMap { $0["celsius"] as? String }
        minCelsiusLabel?.text = "最低 " + formattedCelsius(minCelsius)

        weatherLabel?.text = forecast?["telop"] as? String ?? "-"
        
        let imageData = forecast.flatMap { $0["image"] as? [String: Any?] }
            .flatMap { $0["url"]  as? String }
            .flatMap { URL(string: $0) }
            .flatMap { try? Data(contentsOf: $0) }
        imageView?.image = getImage(imageData: imageData)
    }

    private func getImage(imageData: Data?) -> UIImage {
        guard let imageData = imageData,
            let image = UIImage(data: imageData) else {
                return UIImage(named: "icon_no_image")!
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
