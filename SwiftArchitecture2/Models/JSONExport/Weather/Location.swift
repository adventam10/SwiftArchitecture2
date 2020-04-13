//
//  Location.swift
//
//  Create by am10 on 3/1/2019
//  Copyright © 2019. All rights reserved.
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Location {
    public let area: String
    public let city: String
    public let prefecture: String
}

extension Location: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        area = try values.decodeIfPresent(String.self, forKey: .area) ?? ""
        city = try values.decodeIfPresent(String.self, forKey: .city) ?? ""
        prefecture = try values.decodeIfPresent(String.self, forKey: .prefecture) ?? ""
    }
}
