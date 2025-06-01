//
//  UserDefaultsManager.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 14.05.2025.
//


import SwiftUI
import Combine
import CoreLocation

struct City: Codable, Equatable, Hashable {
    let latitude: Double
    let longitude: Double
    let name: String
}

class UserDefaultsManager: ObservableObject {
    @Published private(set) var addedCities: [City] = []

    init() {
        loadCities()
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: UserDefaults.standard, queue: .main) { [weak self] _ in
                    self?.loadCities()
                }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func loadCities() {
        if let data = UserDefaults.standard.data(forKey: "addedCities"),
           let decoded = try? JSONDecoder().decode([City].self, from: data) {
            addedCities = decoded
        } else {
            addedCities = []
        }
    }

    func addCity(_ city: City) {
        guard !addedCities.contains(city) else { return }

        addedCities.append(city)
        saveCity()
    }

    func removeCity(_ city: City) {
        guard let index = addedCities.firstIndex(of: city) else { return }

        addedCities.remove(at: index)
        saveCity()
    }
    
    private func saveCity() {
        if let encoded = try? JSONEncoder().encode(addedCities) {
            UserDefaults.standard.set(encoded, forKey: "addedCities")
        }
    }
}
