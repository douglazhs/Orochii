//
//  String+defaultValue.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/08/23.
//

import Foundation

extension String {
    /// Return default value `-` if the string is empty
    var notEmpty: String {
        if self.isEmpty { return "-" }
        return self
    }
}

extension String? {
    /// Return empty `String` if the string is nil
    var unwrapped: String {
        if let self { return self }
        return ""
    }
    
    /// Return default value `-` if the string is empty
    var notEmpty: String {
        if let self, !self.isEmpty { return self }
        return "-"
    }
}
