//
//  Int+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 29/07/23.
//

import Foundation

// Int+extension
extension Int {
    /// Unwrap integer value to a valid string
    /// - Returns: Unwrapped value
    func unwrapNil() -> String {
        let formatter = NumberFormatter()
        formatter.nilSymbol = "-"
        return formatter.string(from: NSNumber(value: self)) ?? "-"
    }
}
