//
//  LocationManager.swift
//  OpenWeatherSDK
//
//  Created by Pranav Mistry on 16/08/23.
//

import Foundation
public struct Current : Codable {
    public let dt : Int?
    public let sunrise : Int?
    public let sunset : Int?
    public let temp : Double?
    public let feels_like : Double?
    public let pressure : Int?
    public let humidity : Int?
    public let dew_point : Double?
    public let uvi : Int?
    public let clouds : Int?
    public let visibility : Int?
    public let wind_speed : Double?
    public let wind_deg : Int?
    public let weather : [Weather]?
    public var tempFar: Double?

	enum CodingKeys: String, CodingKey {

		case dt = "dt"
		case sunrise = "sunrise"
		case sunset = "sunset"
		case temp = "temp"
		case feels_like = "feels_like"
		case pressure = "pressure"
		case humidity = "humidity"
		case dew_point = "dew_point"
		case uvi = "uvi"
		case clouds = "clouds"
		case visibility = "visibility"
		case wind_speed = "wind_speed"
		case wind_deg = "wind_deg"
		case weather = "weather"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		dt = try values.decodeIfPresent(Int.self, forKey: .dt)
		sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
		sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
		temp = try values.decodeIfPresent(Double.self, forKey: .temp)
		feels_like = try values.decodeIfPresent(Double.self, forKey: .feels_like)
		pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
		humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
		dew_point = try values.decodeIfPresent(Double.self, forKey: .dew_point)
		uvi = try values.decodeIfPresent(Int.self, forKey: .uvi)
		clouds = try values.decodeIfPresent(Int.self, forKey: .clouds)
		visibility = try values.decodeIfPresent(Int.self, forKey: .visibility)
		wind_speed = try values.decodeIfPresent(Double.self, forKey: .wind_speed)
		wind_deg = try values.decodeIfPresent(Int.self, forKey: .wind_deg)
		weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        tempFar = celsiusToFahrenheit(c: temp!)
	}

}

extension Current {
    func celsiusToFahrenheit(c: Double) -> Double {
       return (c * 9/5) + 32
    }
}
