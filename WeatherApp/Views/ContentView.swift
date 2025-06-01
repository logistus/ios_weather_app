//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 9.05.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingCityList: Bool = false
    @State private var selectedTab: Int = 0
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var locationManager: LocationManager
    
    // Her tab için ayrı ViewModel instance'ları
    @StateObject private var locationViewModel = WeatherViewModel(cityIdentifier: "location")
    @State private var cityViewModels: [String: WeatherViewModel] = [:]
    
    var body: some View {
        NavigationView {
            weatherTabs
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowingCityList = true
                    } label: {
                        Image(systemName: "list.bullet")
                    }
                    .tint(.white)
                }
            }
            .fullScreenCover(isPresented: $isShowingCityList) {
                CityListView(isShowingCityList: $isShowingCityList, selectedTab: $selectedTab)
            }
            .onChange(of: locationManager.currentCoordinates) { oldValue, newValue in
                // Sadece konum tab'i seçiliyken güncelle
                if let coordinates = newValue, selectedTab == 0 {
                    locationViewModel.getWeather(lat: coordinates.latitude, lon: coordinates.longitude)
                }
            }
        }
    }
    
    var weatherTabs: some View {
        ZStack {
            WeatherBackgroundView()
            TabView(selection: $selectedTab) {
                // Konum tab'i
                WeatherDetailView(
                    lat: locationManager.currentCoordinates?.latitude ?? 0.0,
                    lon: locationManager.currentCoordinates?.longitude ?? 0.0,
                    cityName: locationManager.currentCityName ?? "--"
                )
                .tag(0)
                .id("location")
                .environmentObject(locationViewModel)
                .tabItem {
                    Image(systemName: "location")
                }
                
                // Diğer şehirler için tab'ler
                let enumaratedCoordinates = Array(userDefaultsManager.addedCities.enumerated())
                ForEach(enumaratedCoordinates, id: \.element) { index, city in
                    WeatherDetailView(lat: city.latitude, lon: city.longitude, cityName: city.name)
                        .tag(index + 1)
                        .id("\(city.latitude),\(city.longitude)")
                        .environmentObject(getOrCreateViewModel(for: city))
                        .tabItem {
                            Text(city.name)
                        }
                }
            }
            .tint(.white.opacity(0.8))
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
        }
    }
    
    // Her şehir için ayrı ViewModel oluştur veya var olanı getir
    private func getOrCreateViewModel(for city: City) -> WeatherViewModel {
        let key = "\(city.latitude),\(city.longitude)"
        if let existingViewModel = cityViewModels[key] {
            return existingViewModel
        }
        
        let newViewModel = WeatherViewModel(cityIdentifier: key)
        cityViewModels[key] = newViewModel
        return newViewModel
    }
}
