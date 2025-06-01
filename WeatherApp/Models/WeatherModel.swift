//
//  Weather.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 9.05.2025.
//

import Foundation

struct WeatherResponse: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: CurrentWeather
    let hourly: [HourlyWeather]
    let daily: [DailyWeather]
}

struct CurrentWeather: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [Weather]
}

struct HourlyWeather: Decodable, Identifiable {
    var id: String {
        "\(dt)"
    }
    let dt: Int
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [Weather]
    let pop: Double?
}

struct DailyWeather: Decodable, Identifiable {
    var id: String {
        "\(dt)"
    }
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let temp: Temperature
    let feelsLike: DailyFeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Double
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
    let summary: String?
}

struct Weather: Decodable, Identifiable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Temperature: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct DailyFeelsLike: Decodable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}

struct WeatherData {
    var timezone = ""
    var cwFetched = 0
    var cwSunrise = 0
    var cwSunset = 0
    var cwTemperature = "--"
    var cwFeelsLike = ""
    var cwPressure = ""
    var cwHumidity = ""
    var cwDewPoint = ""
    var cwUvi = ""
    var cwClouds = ""
    var cwVisibility = ""
    var cwWindSpeed = ""
    var cwWindDeg = ""
    var cwWindGust = ""
    var cwMain = ""
    var cwDescription = ""
    var cwIcon = ""
        
    var hourlyData: [HourlyWeather] = []
    var dailyData: [DailyWeather] = []
    
    static var empty: WeatherData {
        WeatherData()
    }
}
