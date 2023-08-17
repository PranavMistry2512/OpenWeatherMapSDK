//
//  LocationManager.swift
//  OpenWeatherSDK
//
//  Created by Pranav Mistry on 16/08/23.
//

import Foundation
public struct Temp : Codable {
    public let day : Double?
    public let min : Double?
    public let max : Double?
    public let night : Double?
    public let eve : Double?
    public let morn : Double?
    public var tempMinFar: Double?
    public var tempMaxFar: Double?

	enum CodingKeys: String, CodingKey {

		case day = "day"
		case min = "min"
		case max = "max"
		case night = "night"
		case eve = "eve"
		case morn = "morn"
	}

    public init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		day = try values.decodeIfPresent(Double.self, forKey: .day)
		min = try values.decodeIfPresent(Double.self, forKey: .min)
		max = try values.decodeIfPresent(Double.self, forKey: .max)
		night = try values.decodeIfPresent(Double.self, forKey: .night)
		eve = try values.decodeIfPresent(Double.self, forKey: .eve)
		morn = try values.decodeIfPresent(Double.self, forKey: .morn)
        tempMinFar = celsiusToFahrenheit(c: min!)
        tempMaxFar = celsiusToFahrenheit(c: max!)
	}
}

extension Temp {
    func celsiusToFahrenheit(c: Double) -> Double {
       return (c * 9/5) + 32
    }
}
