//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 9.05.2025.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    @StateObject var locationManager = LocationManager()
    @StateObject var userDefaultsManager = UserDefaultsManager()
    @StateObject var searchManager = SearchManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(userDefaultsManager)
                .environmentObject(searchManager)
        }
    }
}
