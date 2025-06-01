//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 9.05.2025.
//

import Foundation
import Combine
import Alamofire

class WeatherService: WeatherServiceProtocol {
    private let apikey: String
    private let baseURL = "https://api.openweathermap.org/data/3.0/onecall"
    
    init() {
        // Info.plist'ten API key'i oku
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "WeatherAPIKey") as? String else {
            fatalError("WeatherAPIKey not found in Info.plist")
        }
        self.apikey = apiKey
    }
    
    func fetchWeather(lat: Double, lon: Double) -> AnyPublisher<WeatherResponse, Error> {
        let parameters: Parameters = [
            "lat": lat,
            "lon": lon,
            "exclude": "minutely",
            "appid": apikey,
            "units": "metric"
        ]
        
        return request(url: baseURL, parameters: parameters, type: WeatherResponse.self)
    }
    
    private func request<T: Decodable>(url: String, parameters: Parameters, type: T.Type) -> AnyPublisher<T, Error> {
        return Future<T, Error> { promise in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            AF.request(url, parameters: parameters)
                .validate()
                .responseDecodable(of: type, decoder: decoder) { response in
                    switch response.result {
                    case .success(let weather):
                        promise(.success(weather))
                        print("API başarılı - \(Date())")
                    case .failure(let error):
                        if let data = response.data,
                           let jsonString = String(data: data, encoding: .utf8) {
                            print("⛔️ Decoding failed. JSON:\n\(jsonString)")
                        }
                        print("⛔️ Decode error: \(error.localizedDescription)")
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}
