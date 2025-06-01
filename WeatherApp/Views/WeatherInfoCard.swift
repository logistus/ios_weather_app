//
//  CardView.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 12.05.2025.
//

import SwiftUI

struct WeatherInfoCard<Content: View>: View {
    let icon: String
    let title: String
    let content: Content
    
    init(icon: String, title: String, @ViewBuilder content: () -> Content) {
        self.icon = icon
        self.title = title
        self.content = content()
    }
    
    var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 5) {
                    if !icon.isEmpty {
                        Image(systemName: icon)
                    }
                    Text(title.uppercased())
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
                
                content
                    .weatherTextShadow()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.white.opacity(0.1))
                    .shadow(radius: 5)
            )
    }
}

#Preview {
    ZStack {
        WeatherBackgroundView()
        WeatherInfoCard(icon: "temperature", title: "Temperature") {
            Text("25°C")
        }
    }}
