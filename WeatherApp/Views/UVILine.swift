//
//  UVILine.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 21.05.2025.
//

import SwiftUI

struct UVILine: View {
    var body: some View {
        Path() { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(
                to: CGPoint(
                    x: 150,
                    y: 0
                )
            )
        }.stroke(
            LinearGradient(gradient: Gradient(colors: [.green, .yellow, .orange, .red, .purple]), startPoint: .leading, endPoint: .trailing)
            , lineWidth: 5)
    }
}

#Preview {
    UVILine()
}
