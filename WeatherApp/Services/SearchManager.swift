//
//  SearchManager.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 20.05.2025.
//

import Foundation
import MapKit

class SearchManager : NSObject, MKLocalSearchCompleterDelegate, ObservableObject {
    private let searchCompleter = MKLocalSearchCompleter()
    
    @Published var searchResults: [MKLocalSearchCompletion] = []
    @Published var isSearching: Bool = false
    @Published var selectedCityCoordinates: CLLocationCoordinate2D?
    @Published var selectedCityName: String?

    override init() {
        super.init()
        searchCompleter.delegate = self
    }
    
    func searchCities(for query: String) {
        isSearching = true
        searchResults = []
        searchCompleter.queryFragment = query
    }
    
    func clearSearchResults() {
        searchResults = []
    }
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.isSearching = false
            self.searchResults = completer.results
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        DispatchQueue.main.async {
            self.isSearching = false
            print("Arama tamamlama hatası: \(error.localizedDescription)")
            self.searchResults = []
        }
    }
    
    func fetchCityInfoFromSearch(from completion: MKLocalSearchCompletion) {
        let request = MKLocalSearch.Request(completion: completion)
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Detaylı arama hatası: \(error.localizedDescription)")
                    return
                }
                if let placemark = response?.mapItems.first?.placemark {
                    self?.selectedCityCoordinates = placemark.coordinate
                    self?.selectedCityName = placemark.locality
                }
            }
        }
    }
}
