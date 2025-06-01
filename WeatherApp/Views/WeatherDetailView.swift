//
//  HomeLocationView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 13.05.2025.
//

import SwiftUI

struct WeatherDetailView: View {
    let lat: Double
    let lon: Double
    let cityName: String
    
    @EnvironmentObject var weatherViewModel: WeatherViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                LoadingView(isLoading: weatherViewModel.isLoading, errorMessage: weatherViewModel.errorMessage)
                MainWeatherView(lat: lat, lon: lon, cityName: cityName)
                HourlyForecastView(hourlyForecast: weatherViewModel.weatherData.hourlyData, timezone: weatherViewModel.weatherData.timezone)
                DailyForecastView(dailyForecast: weatherViewModel.weatherData.dailyData, timezone: weatherViewModel.weatherData.timezone)
                WeatherGridView()
                Spacer()
            }
            .task {
                if isValidCoordinate(lat: lat, lon: lon) {
                    weatherViewModel.getWeather(lat: lat, lon: lon)
                }
            }
            .padding()
            .foregroundStyle(.white)
        }
    }
}
