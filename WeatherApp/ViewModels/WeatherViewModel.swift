//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 9.05.2025.
//

import Foundation
import Combine

final class WeatherViewModel: ObservableObject {
    @Published private(set) var weatherData: WeatherData = .empty
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    private let weatherService: WeatherServiceProtocol
    private let cityIdentifier: String
    
    init(weatherService: WeatherServiceProtocol = WeatherService(), cityIdentifier: String) {
        self.weatherService = weatherService
        self.cityIdentifier = cityIdentifier
    }
    
    func getWeather(lat: Double, lon: Double) {
        isLoading = true
        errorMessage = nil
        
        weatherService.fetchWeather(lat: lat, lon: lon)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.weatherData = WeatherData(
                    timezone: response.timezone,
                    cwFetched: response.current.dt,
                    cwSunrise: response.current.sunrise,
                    cwSunset: response.current.sunset,
                    cwTemperature: "\(Int(response.current.temp))°",
                    cwFeelsLike: "\(Int(response.current.feelsLike))°",
                    cwPressure: "\(Int(response.current.pressure)) hPa",
                    cwHumidity: "\(Int(response.current.humidity))%",
                    cwDewPoint: "\(Int(response.current.dewPoint))°",
                    cwUvi: "\(Int(response.current.uvi))",
                    cwVisibility: "\(Int(response.current.visibility/1000)) km",
                    cwWindSpeed: "\(Double(response.current.windSpeed)) m/h",
                    cwWindDeg: "\(Int(response.current.windDeg))°",
                    cwWindGust: "\(Double(response.current.windGust ?? 0.0)) m/h",
                    cwMain: response.current.weather.first?.main ?? "",
                    cwDescription: response.current.weather.first?.description ?? "",
                    cwIcon: response.current.weather.first?.icon ?? "",
                    hourlyData: response.hourly,
                    dailyData: response.daily
                )
            }
            .store(in: &cancellables)
    }
}
