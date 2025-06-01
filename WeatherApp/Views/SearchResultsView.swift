//
//  SearchResultsView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 17.05.2025.
//

import SwiftUI
import MapKit

struct SearchResultsView: View {
    let searchResults: [MKLocalSearchCompletion]
    let onCitySelected: (MKLocalSearchCompletion) -> Void
    
    var body: some View {
        List {
            ForEach(searchResults, id: \.self) { completion in
                Text(completion.title)
                    .onTapGesture {
                        onCitySelected(completion)
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
}
