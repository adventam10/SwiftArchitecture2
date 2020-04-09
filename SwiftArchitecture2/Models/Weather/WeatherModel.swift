//
//  WeatherModel.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public final class WeatherModel {

    public let notificationCenter = NotificationCenter.default
    public private(set) var weather: Weather! {
        didSet {
            notificationCenter.post(name: .init(rawValue: "weather"),
                                    object: nil,
                                    userInfo: ["weather": weather!])
        }
    }
    private let weatherAPI: WeatherAPI
    private let cityId: String

    public init(cityId: String, apiClient: APIClient) {
        self.cityId = cityId
        self.weatherAPI = .init(apiClient: apiClient)
    }

    public func requestWeather(_ completion: @escaping (Result<Weather, APIError>) -> Void) {
        weatherAPI.requestWeather(cityId: cityId) { [weak self] result in
            DispatchQueue.main.async {
                if case .success(let weather) = result {
                    self?.weather = weather
                }
                completion(result)
            }
        }
    }
}
