//
//  DateFormatters.swift
//  WeatherApp
//
//  Created by Sinan YILMAZ on 22.05.2025.
//

import Foundation

/// DateFormatter instance'larını cache'leyerek performance iyileştirmesi
struct DateFormatters {
    static func resolvedTimeZone(from identifier: String?) -> TimeZone {
        if let id = identifier, let tz = TimeZone(identifier: id) {
            return tz
        } else {
            return TimeZone.current
        }
    }
    
    static func mediumDateTime(timeZoneIdentifier: String? = nil) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        formatter.timeZone = resolvedTimeZone(from: timeZoneIdentifier)
        return formatter
    }
    
    static func hourMinute(timeZoneIdentifier: String? = nil) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale.current
        formatter.timeZone = resolvedTimeZone(from: timeZoneIdentifier)
        return formatter
    }
    
    static func weekday(timeZoneIdentifier: String? = nil) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale.current
        formatter.timeZone = resolvedTimeZone(from: timeZoneIdentifier)
        return formatter
    }
    
    static func customFormatter(format: String, timeZoneIdentifier: String? = nil) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = resolvedTimeZone(from: timeZoneIdentifier)
        return formatter
    }
}
