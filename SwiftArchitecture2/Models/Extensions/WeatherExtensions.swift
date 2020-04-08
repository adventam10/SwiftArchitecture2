//
//  WeatherExtensions.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public extension Weather {

    var todayForecast: Forecast? {
        return forecasts?.first
    }
    
    var tomorrowForecast: Forecast? {
        return forecasts?.indices.contains(1) == true ? forecasts?[1] : nil
    }
    
    var dayAfterTomorrowForecast: Forecast? {
        return forecasts?.indices.contains(2) == true ? forecasts?[2] : nil
    }
}

public extension Forecast {

    var maxCelsius: String {
        guard let temperature = temperature,
            let max = temperature.max else {
                return ""
        }
        return max.celsius
    }

    var minCelsius: String {
        guard let temperature = temperature,
            let min = temperature.min else {
                return ""
        }
        return min.celsius
    }

    var imageURL: URL? {
        guard let urlText = image?.url else {
            return nil
        }
        return URL(string: urlText)
    }
}
