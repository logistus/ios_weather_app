//
//  LocationTextView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 13.05.2025.
//

import SwiftUI

struct LocationTextView: View {
    var body: some View {
        HStack {
            HStack(spacing: 5) {
                Image(systemName: "location.fill")
                Text("Location")
            }
            .font(.footnote)
        }
    }
}

#Preview {
    LocationTextView()
}
