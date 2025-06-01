//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 9.05.2025.
//

import Foundation
import Combine

protocol WeatherServiceProtocol {
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error>
}
