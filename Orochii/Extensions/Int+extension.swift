//
//  Int+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 29/07/23.
//

import Foundation

// Int+extension
extension Int? {
    /// Unwrap integer value to a valid string. Returns **self** or *- placeholder*
    var nilToStr: String {
        if let value = self { return "\(value)" }
        return "-"
    }
}
