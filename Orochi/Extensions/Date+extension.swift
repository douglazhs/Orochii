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
        let timeInterval = TimeInterval(time)
        let myNsDate = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.string(from: myNsDate)
    }
    
    /// Relative date
    /// - Parameter time: Time interval
    /// - Returns: Localized date
    static func relativeDate(of time: Int) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(
            for: Date(timeIntervalSince1970: TimeInterval(time)),
            relativeTo: Date()
        )
    }
}
