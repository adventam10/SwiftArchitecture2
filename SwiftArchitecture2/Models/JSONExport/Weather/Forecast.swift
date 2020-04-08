//
//	Forecast.swift
//
//	Create by am10 on 3/1/2019
//	Copyright © 2019. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

public struct Forecast : Codable {

	public let date : String
	public let dateLabel : String
	public let image : Image?
	public let telop : String
	public let temperature : Temperature?


	enum CodingKeys: String, CodingKey {
		case date = "date"
		case dateLabel = "dateLabel"
		case image
		case telop = "telop"
		case temperature
	}
	public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		date = try values.decodeIfPresent(String.self, forKey: .date) ?? ""
		dateLabel = try values.decodeIfPresent(String.self, forKey: .dateLabel) ?? ""
        image = try values.decodeIfPresent(Image.self, forKey: .image)
		telop = try values.decodeIfPresent(String.self, forKey: .telop) ?? ""
		temperature = try values.decodeIfPresent(Temperature.self, forKey: .temperature)
	}


}
