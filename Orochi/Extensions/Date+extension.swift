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
    static func getDateBy(
        time: Int,
        format: String = "EEEE, d MMMM yyyy"
    ) -> String {
        let timeInterval = TimeInterval(time)
        let myNsDate = Date(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter()
        formatter.locale = .autoupdatingCurrent
        formatter.dateFormat = format
        return formatter.string(from: myNsDate)
    }
}
