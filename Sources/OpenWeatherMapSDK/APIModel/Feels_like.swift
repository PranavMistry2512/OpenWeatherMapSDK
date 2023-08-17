//
//  LocationManager.swift
//  OpenWeatherSDK
//
//  Created by Pranav Mistry on 16/08/23.
//

import Foundation
public struct Feels_like : Codable {
    public let day : Double?
    public let night : Double?
    public let eve : Double?
    public let morn : Double?

	enum CodingKeys: String, CodingKey {
		case day = "day"
		case night = "night"
		case eve = "eve"
		case morn = "morn"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		day = try values.decodeIfPresent(Double.self, forKey: .day)
		night = try values.decodeIfPresent(Double.self, forKey: .night)
		eve = try values.decodeIfPresent(Double.self, forKey: .eve)
		morn = try values.decodeIfPresent(Double.self, forKey: .morn)
	}
}
