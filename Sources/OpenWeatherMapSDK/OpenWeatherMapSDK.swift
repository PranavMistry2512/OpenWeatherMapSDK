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
    public static func getCurrentWeather(withopenweathermapapikey openweathermapapikey: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody? {
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

    public struct CoordinatesResponse: Decodable {
        public var lon: Double
        public var lat: Double
    }

    public struct WeatherResponse: Decodable {
        public var id: Double
        public var main: String
        public var description: String
        public var icon: String
    }

    public struct MainResponse: Decodable {
        public var temp: Double
        public var feels_like: Double
        public var temp_min: Double
        public var temp_max: Double
        public var pressure: Double
        public var humidity: Double
    }
    
    public struct WindResponse: Decodable {
        public var speed: Double
        public var deg: Double
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

