//
//  Description.swift
//
//  Create by am10 on 3/1/2019
//  Copyright © 2019. All rights reserved.
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Description: Codable {
    public let publicTime: String
    public let text: String

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        publicTime = try values.decodeIfPresent(String.self, forKey: .publicTime) ?? ""
        text = try values.decodeIfPresent(String.self, forKey: .text) ?? ""
    }
}
