//
//  Max.swift
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Max {
    public let celsius: String
    public let fahrenheit: String
}

extension Max: Codable {
    public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            celsius = try values.decodeIfPresent(String.self, forKey: .celsius) ?? ""
            fahrenheit = try values.decodeIfPresent(String.self, forKey: .fahrenheit) ?? ""
    }
}
