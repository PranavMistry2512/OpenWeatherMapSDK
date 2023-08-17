//
//  WeatherManagar.swift
//  OpenWeatherSDK
//
//  Created by Pranav Mistry on 16/08/23.
//

import Foundation
import CoreLocation

@available(iOS 13.0.0, *)
public struct OpenWeatherMapSDK {
    public private(set) var openWeatherMapAPIKey = ""
    public private(set) var locationManager = LocationManager()

    public init(openWeatherMapAPIKey: String) {
        self.openWeatherMapAPIKey = openWeatherMapAPIKey
    }
    
    @available(iOS 13.0.0, *)
    public mutating func getCurrentWeather(withopenweathermapapikey openweathermapapikey: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody? {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(openweathermapapikey)&units=metric") else {
            print("Missing URL")
            return nil
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Error fetching weather data")
            return nil
        }
        
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        return decodedData
    }
}

public struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    public var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    public struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    public var feelsLike: Double { return feels_like }
    public var temprature: Double { return temp }
    public var tempMin: Double { return temp_min }
    public var tempMax: Double { return temp_max }
    public var tempratureFar: Double { return celsiusToFahrenheit(c: temp) }
    public var tempMinFar: Double { return celsiusToFahrenheit(c: temp_min) }
    public var tempMaxFar: Double { return celsiusToFahrenheit(c: temp_max) }
}

extension ResponseBody.MainResponse {
    func celsiusToFahrenheit(c: Double) -> Double {
       return (c * 9/5) + 32
    }
}

