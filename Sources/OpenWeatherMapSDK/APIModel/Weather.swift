//
//  LocationManager.swift
//  OpenWeatherSDK
//
//  Created by Pranav Mistry on 16/08/23.
//

import Foundation
public struct Weather : Codable {
    public let id : Int?
    public let main : String?
    public let description : String?
    public let icon : String?

	enum CodingKeys: String, CodingKey {
		case id = "id"
		case main = "main"
		case description = "description"
		case icon = "icon"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		main = try values.decodeIfPresent(String.self, forKey: .main)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
	}
}
