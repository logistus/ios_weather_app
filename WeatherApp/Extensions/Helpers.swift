//
//  Helpers.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 29.05.2025.
//

import Foundation

func convertUnixTimeStamp(timestamp: Int, format: String, timezone: String) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
    
    // Sık kullanılan formatlar için optimized formatter'ları kullan
    switch format {
    case "HH:mm":
        return DateFormatters.hourMinute(timeZoneIdentifier: timezone).string(from: date)
    case "EEEE":
        return DateFormatters.weekday(timeZoneIdentifier: timezone).string(from: date)
    case "medium":
        return DateFormatters.mediumDateTime(timeZoneIdentifier: timezone).string(from: date)
    default:
        return DateFormatters.customFormatter(format: format, timeZoneIdentifier: timezone).string(from: date)
    }
}

/// Koordinatların geçerli olup olmadığını kontrol eder
func isValidCoordinate(lat: Double, lon: Double) -> Bool {
    return lat >= -90 && lat <= 90 && lon >= -180 && lon <= 180 && !lat.isNaN && !lon.isNaN && !lat.isInfinite && !lon.isInfinite
}

/// String'den Double'a güvenli dönüştürme
func safeDoubleConversion(from string: String) -> Double {
    guard let doubleValue = Double(string.trimmingCharacters(in: .whitespacesAndNewlines)) else {
        return 0.0
    }
    
    // UV Index için mantıklı range kontrolü (0-15 arası)
    let clampedValue = max(0.0, min(15.0, doubleValue))
    return clampedValue
}

/// UV Index offset hesaplaması güvenli hale getirildi
func calculateUVIndexOffset(_ uviValue: Double) -> Double {
    let maxWidth: Double = 150.0
    let maxUVI: Double = 12.0
    
    // Güvenli calculation
    let normalizedUVI = max(0.0, min(maxUVI, uviValue))
    let offset = (normalizedUVI / maxUVI) * maxWidth - (maxWidth / 2.0)
    
    return offset
}

/// Verilen timestamp'in şu anki saat içinde olup olmadığını kontrol eder
func isCurrentHour(timestamp: Int) -> Bool {
    let now = Date()
    let forecastDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
    
    let calendar = Calendar.current
    let nowComponents = calendar.dateComponents([.year, .month, .day, .hour], from: now)
    let forecastComponents = calendar.dateComponents([.year, .month, .day, .hour], from: forecastDate)
    
    return nowComponents.year == forecastComponents.year &&
           nowComponents.month == forecastComponents.month &&
           nowComponents.day == forecastComponents.day &&
           nowComponents.hour == forecastComponents.hour
}

/// Verilen timestamp'in bugün olup olmadığını kontrol eder
func isToday(timestamp: Int) -> Bool {
    let today = Date()
    let forecastDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
    
    return Calendar.current.isDate(forecastDate, inSameDayAs: today)
}

/// Verilen timestamp'in yarın olup olmadığını kontrol eder
func isTomorrow(timestamp: Int) -> Bool {
    guard let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date()) else {
        return false
    }
    let forecastDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
    
    return Calendar.current.isDate(forecastDate, inSameDayAs: tomorrow)
}

/// Verilen timestamp'in geçmişte olup olmadığını kontrol eder (debugging için)
func isPastDate(timestamp: Int) -> Bool {
    let now = Date()
    let forecastDate = Date(timeIntervalSince1970: TimeInterval(timestamp))
    
    return forecastDate < now
}
