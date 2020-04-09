//
//  WeatherAPI.swift
//  Models
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public class WeatherAPI {

    private let apiClient: APIClient

    public init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

    public func requestWeather(cityId: String, completion: @escaping (Result<Weather, APIError>) -> Void) {
        apiClient.request(WeatherAPIRequest.getWeather(cityId: cityId)) { result in
            switch result {
            case .success(let data):
                if let result = try? JSONDecoder().decode(Weather.self, from: data) {
                    completion(.success(result))
                } else {
                    completion(.failure(.invalidJSON))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

public protocol WeatherRequest: Request {
}

public extension WeatherRequest {

    var baseURL: URL {
        return URL(string: "http://weather.livedoor.com/forecast/webservice/json/v1")!
    }

    var method: HTTPMethod {
        return .get
    }

    var path: String {
        return ""
    }
}

public enum WeatherAPIRequest: WeatherRequest {

    case getWeather(cityId: String)
    public var parameter: [String : Any] {
        switch self {
        case .getWeather(let cityId):
            return ["city": cityId]
        }
    }
}
