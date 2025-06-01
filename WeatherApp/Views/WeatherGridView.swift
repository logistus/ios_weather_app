//
//  WeatherGridView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 29.05.2025.
//

import SwiftUI

struct WeatherGridView: View {
    @EnvironmentObject var weatherViewModel: WeatherViewModel
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 8) {
            WeatherInfoCard(
                icon: "humidity",
                title: "Humidity"
            ) {
                Text("\(weatherViewModel.weatherData.cwHumidity)")
                    .font(.title)
            }
            
            WeatherInfoCard(
                icon: "gauge.with.dots.needle.50percent",
                title: "Pressure"
            ) {
                Text("\(weatherViewModel.weatherData.cwPressure)")
                    .font(.title)
            }
            
            WeatherInfoCard(
                icon: "wind",
                title: "Wind"
            ) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("Speed")
                        Spacer()
                        Text("\(weatherViewModel.weatherData.cwWindSpeed)")
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text("Degree")
                        Spacer()
                        Text("\(weatherViewModel.weatherData.cwWindDeg)")
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                    }
                    HStack {
                        Text("Gust")
                        Spacer()
                        Text("\(weatherViewModel.weatherData.cwWindGust)")
                            .foregroundStyle(.secondary)
                            .fontWeight(.bold)
                    }
                }
                .font(.subheadline)
            }
            WeatherInfoCard(
                icon: "sun.max.fill",
                title: "UV Index"
            ) {
                let uviValue = safeDoubleConversion(from: weatherViewModel.weatherData.cwUvi)
                Text("\(weatherViewModel.weatherData.cwUvi)")
                    .font(.title)
                ZStack {
                    UVILine()
                    Circle()
                        .fill(Color.white)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 10, height: 10)
                        // Daireyi dinamik olarak konumlandır
                        // UV Index (0-12) ölçeğini piksel konumuna (0-150) dönüştür
                        // ve ZStack'in merkezini hesaba kat
                        .offset(x: calculateUVIndexOffset(uviValue), y: -5)
                }
                .frame(height: 10)
            }
        }
    }
}
