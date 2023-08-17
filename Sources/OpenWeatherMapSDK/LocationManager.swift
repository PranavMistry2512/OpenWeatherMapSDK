//
//  LocationManager.swift
//  OpenWeatherSDK
//
//  Created by Pranav Mistry on 16/08/23.
//

import Foundation
import CoreLocation

@available(iOS 13.0, *)
public class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    @Published public var location: CLLocationCoordinate2D?
    @Published public var isLoading = false
    public var locationCity: String?
    
    public override init() {
        super.init()
        manager.delegate = self
    }
    
    public func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last?.coordinate
        isLoading = false
        fetchLocationCity { city, error in
            guard let city = city, error == nil else { return }
            print(city)
            self.locationCity = city
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
    
    func fetchLocationCity(completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: location!.latitude, longitude: location!.longitude)) { completion($0?.first?.locality, $1) }
    }
}
