//
//	Temperature.swift
//
//	Create by am10 on 3/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Temperature : Codable {

	public let max : Max?
	public let min : Max?


	enum CodingKeys: String, CodingKey {
		case max = "max"
		case min = "min"
	}
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		max = try values.decodeIfPresent(Max.self, forKey: .max)
		min = try values.decodeIfPresent(Max.self, forKey: .min)
	}


}
