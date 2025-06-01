//
//  WeatherBackgroundView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 12.05.2025.
//

import SwiftUI

struct WeatherBackgroundView: View {
    var body: some View {
        /*
        LinearGradient(colors: [.blue, .cyan], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
         */
        LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
    }
}

#Preview {
    WeatherBackgroundView()
}
