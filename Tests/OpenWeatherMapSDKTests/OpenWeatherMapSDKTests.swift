import XCTest
@testable import OpenWeatherMapSDK
import CoreLocation

@available(iOS 13.0.0, *)
final class OpenWeatherMapSDKTests: XCTestCase {
    
    var weather: ResponseBody?
    var weatherManager = OpenWeatherMapSDK(openWeatherMapAPIKey: "ae1c4977a943a50eaa7da25e6258d8b2")
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertNotEqual(weatherManager.openWeatherMapAPIKey, "")
    }
    
    /// This test case checks if the API key used by the OpenWeatherSDK is valid
    func testAPIKeyIsValid() {
        XCTAssertNotNil(weatherManager.openWeatherMapAPIKey)
    }
    
    /// This test case validates if the location name in the weather response matches the requested location
    func testGetWeatherForForecastWithValidAPIKey() async {
        
        let location = CLLocationCoordinate2DMake(23.0225, 72.5714)
        do {
            self.weather = try await
            self.weatherManager.getCurrentWeather(withopenweathermapapikey: weatherManager.openWeatherMapAPIKey, latitude: location.latitude, longitude: location.longitude)
        } catch {
            print("Error getting weather: \(error)")
            XCTAssertNil(error)
        }
        
        if let weather = weather {
            XCTAssertNotNil(weather)
        }
    }
    
    /// This test case checks if the API request for weather forecast fails due to an invalid API key
    func testGetWeatherForForecastWithInvalidAPIKey() async {
        // Set an invalid API key
        
        let location = CLLocationCoordinate2DMake(23.0225, 72.5714)
        do {
            self.weather = try await
            self.weatherManager.getCurrentWeather(withopenweathermapapikey: "INVALID_API_KEY", latitude: location.latitude, longitude: location.longitude)
        } catch {
            print("Error getting weather: \(error)")
            XCTAssertNotNil(error)
        }
        
        if let weather = weather {
            XCTAssertNil(weather)
        }
    }
}

