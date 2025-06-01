//
//  WeatherTextShadowModifier.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 12.05.2025.
//

import SwiftUI

extension View {
    func weatherTextShadow() -> some View {
        self.shadow(color: .black.opacity(0.2), radius: 2, x: -1, y: -1)
    }
}
