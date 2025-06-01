//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 12.05.2025.
//

import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    private var lastLocation: CLLocation?
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentCoordinates: CLLocationCoordinate2D?
    @Published var currentCityName: String?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startMonitoringSignificantLocationChanges()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // Eğer konum çok az değiştiyse yeniden lokasyon bulma işlemi yapma
        if let last = lastLocation,
           location.distance(from: last) < 100 {
            return
        }
        
        lastLocation = location
        currentCoordinates = location.coordinate
        reverseGeocode(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
    
    func reverseGeocode(lat: Double, lon: Double) {
        let coordinate = CLLocation(latitude: lat, longitude: lon)
        geoCoder.reverseGeocodeLocation(coordinate) { [weak self] placemarks, _ in
            //print(placemarks?.first?.location?.coordinate ?? "bulunamadı")
            if let city = placemarks?.first?.locality {
                self?.currentCityName = city
            }
        }
    }
    
}

extension CLLocationCoordinate2D: @retroactive Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
