//
//  CityListContent.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 17.05.2025.
//

import SwiftUI

struct CityListContent: View {
    @Binding var isShowingCityList: Bool
    @Binding var selectedTab: Int
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var userDefaultsManager: UserDefaultsManager
    
    var body: some View {
        List {
            // Konum satırı
            CityListRow(
                isShowingCityList: $isShowingCityList,
                selectedTab: $selectedTab,
                lat: locationManager.currentCoordinates?.latitude ?? 0.0,
                lon: locationManager.currentCoordinates?.longitude ?? 0.0,
                cityName: locationManager.currentCityName ?? "",
                tabIndex: 0
            )
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            
            // Kayıtlı şehirler
            ForEach(Array(userDefaultsManager.addedCities.enumerated()), id: \.element) { index, city in
                CityListRow(
                    isShowingCityList: $isShowingCityList,
                    selectedTab: $selectedTab,
                    lat: city.latitude,
                    lon: city.longitude,
                    cityName: city.name,
                    tabIndex: index + 1
                )
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        userDefaultsManager.removeCity(city)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .listRowSpacing(10.0)
    }
}
