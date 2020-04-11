//
//  DummyAPIClient.swift
//  Models
//
//  Created by am10 on 2020/04/09.
//  Copyright © 2020 am10. All rights reserved.
//

import Foundation

public final class DummyAPIClient: APIClient {
    public static let shared = DummyAPIClient()

    private init() {}

    public func request(_ request: Request, completion: @escaping (Result<Data, APIError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let api = request as? WeatherAPIRequest,
                let weakSelf = self else {
                completion(.failure(.server))
                return
            }
            completion(.success(weakSelf.getJSONData(api: api)))
        }
    }

    private func getJSONData(api: WeatherAPIRequest) -> Data {
        let fileName = getFileName(api: api)
        let url = Bundle(for: DummyAPIClient.self).url(forResource: fileName, withExtension: "json")
        return try! Data(contentsOf: url!)
    }

    private func getFileName(api: WeatherAPIRequest) -> String {
        switch api {
        case .getWeather:
            return "get_weather_city_400010"
        }
    }
}
