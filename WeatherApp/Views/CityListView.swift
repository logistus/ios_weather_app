//
//  CityListView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 13.05.2025.
//

import SwiftUI
import CoreLocation
import MapKit

struct CityListView: View {
    @State private var newCity: String = ""
    @State private var isSearchActive: Bool = false
    
    @Binding var isShowingCityList: Bool
    @Binding var selectedTab: Int
    
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var searchManager: SearchManager
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if isSearchActive {
                    SearchResultsView(
                        searchResults: searchManager.searchResults,
                        onCitySelected: { completion in
                            searchManager.fetchCityInfoFromSearch(from: completion)
                        }
                    )
                } else {
                    CityListContent(
                        isShowingCityList: $isShowingCityList,
                        selectedTab: $selectedTab,
                    )
                }
            }
            .navigationTitle("Weather")
        }
        .searchable(text: $newCity, isPresented: $isSearchActive, prompt: Text("Search for a city"))
        .onChange(of: newCity) { oldValue, newValue in
            if !newValue.isEmpty {
                searchManager.searchCities(for: newValue)
            } else {
                searchManager.clearSearchResults()
            }
        }
        .onChange(of: searchManager.selectedCityName) { oldCityName, newCityName in
            if let cityName = newCityName {
                let newCity = City(
                    latitude: searchManager.selectedCityCoordinates?.latitude ?? 0.0,
                    longitude: searchManager.selectedCityCoordinates?.longitude ?? 0.0,
                    name: cityName
                )
                userDefaultsManager.addCity(newCity)
                if let index = userDefaultsManager.addedCities.firstIndex(where: {$0.name == cityName}) {
                    selectedTab = index + 1
                }
                isShowingCityList = false
            }
        }
        .onDisappear {
            searchManager.clearSearchResults()
            isSearchActive = false
        }
    }
}
