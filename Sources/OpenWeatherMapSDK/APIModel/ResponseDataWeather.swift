//
//  LocationManager.swift
//  OpenWeatherSDK
//
//  Created by Pranav Mistry on 16/08/23.
//

import Foundation
public struct ResponseDataWeather : Codable {
    public let lat : Double?
    public let lon : Double?
    public let timezone : String?
    public let timezone_offset : Int?
    public let current : Current?
    public let daily : [Daily]?

	enum CodingKeys: String, CodingKey {

		case lat = "lat"
		case lon = "lon"
		case timezone = "timezone"
		case timezone_offset = "timezone_offset"
		case current = "current"
		case daily = "daily"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)
		timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
		timezone_offset = try values.decodeIfPresent(Int.self, forKey: .timezone_offset)
		current = try values.decodeIfPresent(Current.self, forKey: .current)
		daily = try values.decodeIfPresent([Daily].self, forKey: .daily)
	}

}

extension ResponseDataWeather {
    func celsiusToFahrenheit(c: Double) -> Double {
       return (c * 9/5) + 32
    }
}
