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
    public static func getCurrentWeather(withopenweathermapapikey openweathermapapikey: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseDataWeather? {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/onecall?units=metric&exclude=minutely,hourly&appid=\(openweathermapapikey)&lat=\(latitude)&lon=\(longitude)") else {
            print("Missing URL")
            return nil
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            print("Error fetching weather data")
            return nil
        }
        
        let decodedData = try JSONDecoder().decode(ResponseDataWeather.self, from: data)
        return decodedData
    }
}
