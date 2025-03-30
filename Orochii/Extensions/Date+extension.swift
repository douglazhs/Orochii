//
//  Date+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 31/05/23.
//

import SwiftUI

extension Date {
    /// Get date from time interval
    /// - Parameter time: Time Interval
    /// - Returns: Formatted date
    static func getDate(
        of time: Int,
        format: String = "EEEE, d MMMM yyyy"
    ) -> String {
        guard time != 0 else { return "-" }
        let timeInterval = TimeInterval(time)
        let myNsDate = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.string(from: myNsDate)
    }
    
    /// Relative date. Ex: 1 day ago
    /// - Parameter time: Time interval
    /// - Returns: Localized date
    static func relativeDate(of time: Int) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        formatter.unitsStyle = .short
        return formatter.localizedString(
            for: Date(timeIntervalSince1970: TimeInterval(time)),
            relativeTo: .now
        )
    }
    
    /// Get date from string
    /// - Parameter string: Date in string format
    /// - Returns: Converted date
    static func convert(_ string: String, format: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let date = formatter.date(from: string) {
            return date
        }
        return .now
    }
    
    /// Get date from string
    /// - Parameter string: Date in string format
    /// - Returns: Converted date string
    static func fromString(_ string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = formatter.date(from: string) {
            formatter.dateFormat = "dd MMM yyyy"
            return formatter.string(from: date)
        }
        return ""
    }
}
