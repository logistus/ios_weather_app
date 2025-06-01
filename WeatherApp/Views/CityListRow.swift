//
//  CityListRow.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 14.05.2025.
//

import SwiftUI

struct CityListRow: View {
    @StateObject private var weatherViewModel = WeatherViewModel(cityIdentifier: "cityRow")
    
    @Binding var isShowingCityList: Bool
    @Binding var selectedTab: Int
    let lat: Double
    let lon: Double
    let cityName: String
    let tabIndex: Int
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.gray.opacity(0.3))
            .frame(height: 120)
            .overlay(
                HStack {
                    Image(weatherViewModel.weatherData.cwIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    Spacer()
                    VStack(alignment: .leading, spacing: 8) {
                        Text(cityName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Text(
                            convertUnixTimeStamp(
                                timestamp: weatherViewModel.weatherData.cwFetched,
                                format: "medium",
                                timezone: weatherViewModel.weatherData.timezone
                            )
                        )
                        .font(.footnote)
                        Spacer()
                        Text(weatherViewModel.weatherData.cwDescription)
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    VStack {
                        Text("\(weatherViewModel.weatherData.cwTemperature)")
                            .font(.system(size: 44, weight: .thin))
                            .foregroundColor(.white)
                        HStack {
                            Text("H:")
                            Text("\(Int(weatherViewModel.weatherData.dailyData.first?.temp.max ?? 0.0))°")
                            Text("L:")
                            Text("\(Int(weatherViewModel.weatherData.dailyData.first?.temp.min ?? 0.0))°")
                        }
                        .font(.footnote)
                    }
                }
                .padding()
            )
            .padding(.horizontal)
            .task {
                weatherViewModel.getWeather(lat: lat, lon: lon)
            }
            .onTapGesture {
                selectedTab = tabIndex
                isShowingCityList = false
            }
    }
}
