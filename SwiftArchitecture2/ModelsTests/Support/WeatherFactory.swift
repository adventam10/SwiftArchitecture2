//
//  WeatherFactory.swift
//  ModelsTests
//
//  Created by am10 on 2020/04/08.
//  Copyright © 2020 am10. All rights reserved.
//

@testable import Models

final class WeatherFactory {

    static func makeImageJSONText(link: String, url: String, title: String, height: Int, width: Int) -> String {
        let text = """
        {
        "link": "\(link)",
        "url": "\(url)",
        "title": "\(title)",
        "height": \(height),
        "width": \(width)
        }
        """
        return text
    }

    static func makeProviderJSONText(link: String, name: String) -> String {
        let text = """
        {
        "link": "\(link)",
        "name": "\(name)"
        }
        """
        return text
    }

    static func makeDescriptionJSONText(text: String, publicTime: String) -> String {
        let text = """
        {
        "text": "\(text)",
        "publicTime": "\(publicTime)"
        }
        """
        return text
    }

    static func makeMaxJSONText(celsius: String, fahrenheit: String) -> String {
        let text = """
        { "celsius": "\(celsius)", "fahrenheit": "\(fahrenheit)" }
        """
        return text
    }

    static func makeLocationJSONText(area: String, city: String, prefecture: String) -> String {
        let text = """
        {
        "area": "\(area)",
        "city": "\(city)",
        "prefecture": "\(prefecture)"
        }
        """
        return text
    }

    static func makeCopyrightJSONText(link: String, title: String, image: Image?, provider: Provider?) -> String {
        let providers = (provider != nil) ? encodeJSON(provider) : ""
        let text = """
        {
        "link": "\(link)",
        "title": "\(title)",
        "image": \(encodeJSON(image)),
        "provider": [\(providers)]
        }
        """
        return text
    }

    static func makeTemperatureJSONText(max: Max?, min: Max?) -> String {
        let text = """
        {
        "max": \(encodeJSON(max)),
        "min": \(encodeJSON(min))
        }
        """
        return text
    }

    static func makeForecastJSONText(date: String, dateLabel: String, image: Image?,
                      telop: String, temperature: Temperature?) -> String {
        let text = """
        {
        "dateLabel": "\(dateLabel)",
        "telop": "\(telop)",
        "date": "\(date)",
        "temperature": \(encodeJSON(temperature)),
        "image": \(encodeJSON(image))
        }
        """
        return text
    }

    

    
    
    static func makeWeather(link: String, title: String, copyright: Copyright?,
                     descriptionField: Description?, publicTime: String,
                     location: Location?, forecast: Forecast?,
                     pinpointLocation: Provider?) -> Weather? {
        let pinpointLocations = (pinpointLocation != nil) ? encodeJSON(pinpointLocation) : ""
        let forecasts = (forecast != nil) ? encodeJSON(forecast) : ""
        let text = """
        {
        "link": "\(link)",
        "title": "\(title)",
        "publicTime": "\(publicTime)",
        "copyright": \(encodeJSON(copyright)),
        "description": \(encodeJSON(descriptionField)),
        "location": \(encodeJSON(location)),
        "pinpointLocations": [\(pinpointLocations)],
        "forecasts": [\(forecasts)]
        }
        """
        return try? JSONDecoder().decode(Weather.self, from: text.data(using: .utf8)!)
    }
    
    static func makeWeather(forecasts: [Forecast?]) -> Weather? {
        let forecastsText = forecasts.map { encodeJSON($0) }.joined(separator: ", ")
        let text = """
        {
        "link": "",
        "title": "",
        "publicTime": "",
        "copyright": null,
        "description": null,
        "location": null,
        "pinpointLocations": [],
        "forecasts": [\(forecastsText)]
        }
        """
        return try? JSONDecoder().decode(Weather.self, from: text.data(using: .utf8)!)
    }
    
    private static func encodeJSON<T>(_ json: T?) -> String where T: Codable {
        guard let data = try? JSONEncoder().encode(json),
            let jsonText = String(data: data, encoding: .utf8) else {
                return "null"
        }
        return jsonText
    }
}
