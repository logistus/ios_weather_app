//
//  DailyForecast.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 29.05.2025.
//

import SwiftUI

struct DailyForecastView: View {
    let dailyForecast: [DailyWeather]
    let timezone: String
    
    var body: some View {
        WeatherInfoCard(icon: "list.bullet.rectangle", title: "8 Days Forecast") {
            VStack(spacing: 10) {
                ForEach(dailyForecast, id: \.id) { forecast in
                    HStack(alignment: .center, spacing: 0) {
                        if isToday(timestamp: forecast.dt) {
                            Text("Today")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else if isTomorrow(timestamp: forecast.dt) {
                            Text("Tomorrow")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else {
                            Text("\(convertUnixTimeStamp(timestamp: forecast.dt, format: "EEEE", timezone: timezone))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        if let weatherIcon = forecast.weather.first?.icon,
                           let iconImage = UIImage(named: weatherIcon) {
                            Image(uiImage: iconImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else {
                            Image(systemName: "cloud.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.gray)
                        }
                        Text("\(Int(forecast.temp.min))°/ \(Int(forecast.temp.max))°")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .weatherTextShadow()
                }
            }
        }
    }
}
