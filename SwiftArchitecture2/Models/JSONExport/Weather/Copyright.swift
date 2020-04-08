//
//	Copyright.swift
//
//	Create by am10 on 3/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Copyright : Codable {

	public let image : Image?
	public let link : String
	public let provider : [Provider]?
	public let title : String


	enum CodingKeys: String, CodingKey {
		case image
		case link = "link"
		case provider = "provider"
		case title = "title"
	}
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		image = try values.decodeIfPresent(Image.self, forKey: .image)
		link = try values.decodeIfPresent(String.self, forKey: .link) ?? ""
		provider = try values.decodeIfPresent([Provider].self, forKey: .provider)
		title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""
	}


}
