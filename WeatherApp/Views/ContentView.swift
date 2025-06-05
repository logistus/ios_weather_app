//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 9.05.2025.
//

import SwiftUI

struct ContentView: View {
    // MARK: - State Properties
    @State private var isShowingCityList = false
    @State private var selectedTab = 0
    
    // MARK: - Environment Objects
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    @EnvironmentObject var locationManager: LocationManager
    
    // MARK: - View Models
    @StateObject private var weatherViewModelManager = WeatherViewModelManager()
    
    var body: some View {
        NavigationView {
            mainContent
                .toolbar {
                    navigationToolbar
                }
                .fullScreenCover(isPresented: $isShowingCityList) {
                    CityListView(
                        isShowingCityList: $isShowingCityList,
                        selectedTab: $selectedTab
                    )
                }
        }
        .onAppear {
            setupViewModels()
        }
        .onChange(of: userDefaultsManager.addedCities) {
            setupViewModels()
        }
    }
}

// MARK: - View Components
private extension ContentView {
    
    var mainContent: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            weatherTabView
        }
    }
    
    var navigationToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { isShowingCityList = true }) {
                Image(systemName: "list.bullet")
                    .foregroundColor(.white)
            }
        }
    }
    
    var weatherTabView: some View {
        TabView(selection: $selectedTab) {
            locationTab
            cityTabs
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .tint(.white.opacity(0.8))
    }
    
    var locationTab: some View {
        WeatherDetailView(
            lat: locationManager.currentCoordinates?.latitude ?? 0.0,
            lon: locationManager.currentCoordinates?.longitude ?? 0.0,
            cityName: locationManager.currentCityName ?? "Current Location"
        )
        .tag(0)
        .environmentObject(weatherViewModelManager.locationViewModel)
        .tabItem {
            Label("Location", systemImage: "location")
        }
    }
    
    @ViewBuilder
    var cityTabs: some View {
        ForEach(Array(userDefaultsManager.addedCities.enumerated()), id: \.offset) { index, city in
            WeatherDetailView(
                lat: city.latitude,
                lon: city.longitude,
                cityName: city.name
            )
            .tag(index + 1)
            .environmentObject(weatherViewModelManager.viewModel(for: city))
            .tabItem {
                Label(city.name, systemImage: "bullet.circle")
            }
        }
    }
}

// MARK: - Helper Methods
private extension ContentView {
    func setupViewModels() {
        weatherViewModelManager.setupViewModels(for: userDefaultsManager.addedCities)
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .environmentObject(UserDefaultsManager())
        .environmentObject(LocationManager())
}
