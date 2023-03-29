//
//  TrackerPopUpObserver.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/03/23.
//

import SwiftUI

class TrackerPopUpObserver: ObservableObject {
    @Published var entryType: EntryType = .picker
    
    /// TextField formatter
    /// - Returns: Formatter instance
    func textFieldformatter() -> Formatter {
        let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.generatesDecimalNumbers = true
            formatter.maximumFractionDigits = 1
            return formatter
        }()
        return formatter
    }
    
    /// Validate keyboard field, limiting the score in 0-10
    /// - Parameters:
    ///   - value: New value
    ///   - selection: TextField selection
    func validateFieldInput(
        of value: Double,
        to selection: Binding<Double>
    ) {
        if value > 10 { selection.wrappedValue = 10 }
    }
}
