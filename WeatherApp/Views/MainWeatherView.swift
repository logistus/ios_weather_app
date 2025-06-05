//
//  MainWeatherView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 29.05.2025.
//

import SwiftUI

struct MainWeatherView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    let lat: Double
    let lon: Double
    let cityName: String
    
    
    var body: some View {
        /*
        HStack(spacing: 10) {
            
            Button {
                guard isValidCoordinate(lat: lat, lon: lon) else {
                    print("Warning: Invalid coordinates provided")
                    return
                }
                weatherViewModel.getWeather(lat: lat, lon: lon)
            } label: {
                Image(systemName: "arrow.clockwise")
            }
        }
        .padding(.bottom, 5)
         */
        
        Text(cityName)
            .font(.largeTitle)
            .weatherTextShadow()
            .padding(.top, 5)
        Text(
            convertUnixTimeStamp(
                timestamp: weatherViewModel.weatherData.cwFetched,
                format: "medium",
                timezone: weatherViewModel.weatherData.timezone
            )
        )
        .font(.footnote)
        
        HStack (spacing: 20) {
            if let iconImage = UIImage(named: weatherViewModel.weatherData.cwIcon) {
                Image(uiImage: iconImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
            } else {
                // Fallback icon
                Image(systemName: "cloud.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80)
                    .foregroundColor(.gray)
            }
            VStack {
                Text("\(weatherViewModel.weatherData.cwTemperature)")
                    .font(.system(size: WeatherDetails.Texts.temperatureFontSize))
                    .weatherTextShadow()
            }
        }
        .padding(.bottom, 10)
    }
}
