//
//  WeatherViewModelManager.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 5.06.2025.
//

import Foundation

class WeatherViewModelManager: ObservableObject {
    @Published private var cityViewModels: [String: WeatherViewModel] = [:]
    
    lazy var locationViewModel = WeatherViewModel(cityIdentifier: "current_location")
    
    func viewModel(for city: City) -> WeatherViewModel {
        let key = cityKey(for: city)
        
        if let existingViewModel = cityViewModels[key] {
            return existingViewModel
        }
        
        let newViewModel = WeatherViewModel(cityIdentifier: key)
        cityViewModels[key] = newViewModel
        return newViewModel
    }
    
    func setupViewModels(for cities: [City]) {
        // Mevcut şehirlerde olmayan ViewModels'i temizle
        let currentKeys = Set(cities.map { cityKey(for: $0) })
        cityViewModels = cityViewModels.filter { currentKeys.contains($0.key) }
        
        // Yeni şehirler için ViewModels oluştur
        for city in cities {
            _ = viewModel(for: city)
        }
    }
    
    private func cityKey(for city: City) -> String {
        return "\(city.latitude)_\(city.longitude)_\(city.name)"
    }
}
