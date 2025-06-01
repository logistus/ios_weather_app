//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 29.05.2025.
//

import SwiftUI

struct HourlyForecastView: View {
    let hourlyForecast: [HourlyWeather]
    let timezone: String
    
    var body: some View {
        WeatherInfoCard(icon: "clock", title: "Hourly Forecast") {
            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(hourlyForecast.prefix(24), id: \.id) { forecast in
                        VStack {
                            Text("\(Int(forecast.temp))°")
                                .fontWeight(.semibold)
                            if let weatherIcon = forecast.weather.first?.icon,
                               let iconImage = UIImage(named: weatherIcon) {
                                Image(uiImage: iconImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                            } else {
                                Image(systemName: "cloud.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30)
                                    .foregroundColor(.gray)
                            }
                            if isCurrentHour(timestamp: forecast.dt) {
                                Text("Now")
                                    .font(.footnote)
                            } else {
                                Text("\(convertUnixTimeStamp(timestamp: forecast.dt, format: "HH:mm", timezone: timezone))")
                                    .font(.footnote)
                            }

                        }
                        .weatherTextShadow()
                    }
                }
            }
        }
    }
}
