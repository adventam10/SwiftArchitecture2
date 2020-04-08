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

    static func makeWeatherJSONText(link: String, title: String, copyright: Copyright?,
                                    descriptionField: Description?, publicTime: String,
                                    location: Location?, forecast: Forecast?,
                                    pinpointLocation: Provider?) -> String {
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
        return text
    }

    private static func encodeJSON<T>(_ json: T?) -> String where T: Codable {
        guard let data = try? JSONEncoder().encode(json),
            let jsonText = String(data: data, encoding: .utf8) else {
                return "null"
        }
        return jsonText
    }
}

extension WeatherFactory {
    static func makeForecast() -> Forecast {
        let jsonText = WeatherFactory.makeForecastJSONText(date: "date", dateLabel: "dateLabel", image: makeImage(), telop: "telop", temperature: makeTemperature())
        return try! JSONDecoder().decode(Forecast.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeLocation() -> Location {
        let jsonText = WeatherFactory.makeLocationJSONText(area: "area", city: "city", prefecture: "prefecture")
        return try! JSONDecoder().decode(Location.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeDescription() -> Description {
        let jsonText = WeatherFactory.makeDescriptionJSONText(text: "text", publicTime: "publicTime")
        return try! JSONDecoder().decode(Description.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeCopyright() -> Copyright {
        let jsonText = WeatherFactory.makeCopyrightJSONText(link: "link", title: "title", image: makeImage(), provider: makeProvider())
        return try! JSONDecoder().decode(Copyright.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeImage() -> Image {
        let jsonText = WeatherFactory.makeImageJSONText(link:"link", url: "url", title: "title", height: 11, width: 13)
        return try! JSONDecoder().decode(Image.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeProvider() -> Provider {
        let jsonText = WeatherFactory.makeProviderJSONText(link: "link", name: "name")
        return try! JSONDecoder().decode(Provider.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeTemperature() -> Temperature {
        let jsonText = WeatherFactory.makeTemperatureJSONText(max: makeMax(), min: makeMin())
        return try! JSONDecoder().decode(Temperature.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeMin() -> Max {
        let jsonText = WeatherFactory.makeMaxJSONText(celsius: "celsiusMin", fahrenheit: "fahrenheitMin")
        return try! JSONDecoder().decode(Max.self, from: jsonText.data(using: .utf8)!)
    }

    static func makeMax() -> Max {
        let jsonText = WeatherFactory.makeMaxJSONText(celsius: "celsiusMax", fahrenheit: "fahrenheitMax")
        return try! JSONDecoder().decode(Max.self, from: jsonText.data(using: .utf8)!)
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
}
