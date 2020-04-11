//
//  Weather.swift
//
//  Create by am10 on 3/1/2019
//  Copyright © 2019. All rights reserved.
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Weather: Codable {
    public let copyright: Copyright?
    public let descriptionField: Description?
    public let forecasts: [Forecast]?
    public let link: String
    public let location: Location?
    public let pinpointLocations: [Provider]?
    public let publicTime: String
    public let title: String

    enum CodingKeys: String, CodingKey {
        case copyright
        case descriptionField = "description"
        case forecasts
        case link
        case location
        case pinpointLocations
        case publicTime
        case title
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        copyright = try values.decodeIfPresent(Copyright.self, forKey: .copyright)
        descriptionField = try values.decodeIfPresent(Description.self, forKey: .descriptionField)
        forecasts = try values.decodeIfPresent([Forecast].self, forKey: .forecasts)
        link = try values.decodeIfPresent(String.self, forKey: .link) ?? ""
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        pinpointLocations = try values.decodeIfPresent([Provider].self, forKey: .pinpointLocations)
        publicTime = try values.decodeIfPresent(String.self, forKey: .publicTime) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
    }
}
