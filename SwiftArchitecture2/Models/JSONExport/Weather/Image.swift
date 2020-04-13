//
//  Image.swift
//
//  Create by am10 on 3/1/2019
//  Copyright © 2019. All rights reserved.
//  Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Image {
    public let height: Int
    public let link: String
    public let title: String
    public let url: String
    public let width: Int
}

extension Image: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height) ?? 0
        link = try values.decodeIfPresent(String.self, forKey: .link) ?? ""
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
        url = try values.decodeIfPresent(String.self, forKey: .url) ?? ""
        width = try values.decodeIfPresent(Int.self, forKey: .width) ?? 0
    }
}
