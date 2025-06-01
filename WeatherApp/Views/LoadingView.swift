//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 29.05.2025.
//

import SwiftUI

struct LoadingView: View {
    let isLoading: Bool
    let errorMessage: String?
    
    var body: some View {
        if isLoading {
            ProgressView()
        } else if let error = errorMessage {
            Text("Error: \(error)")
                .foregroundStyle(.red)
        }
    }
}
