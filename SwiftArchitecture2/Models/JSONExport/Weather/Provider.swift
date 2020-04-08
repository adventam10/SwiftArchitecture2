//
//	Provider.swift
//
//	Create by am10 on 3/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Provider : Codable {

	public let link : String
	public let name : String


	enum CodingKeys: String, CodingKey {
		case link = "link"
		case name = "name"
	}
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		link = try values.decodeIfPresent(String.self, forKey: .link) ?? ""
		name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
	}


}
