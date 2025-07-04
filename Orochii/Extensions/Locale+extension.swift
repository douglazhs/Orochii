//
//  Locale+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/03/25.
//

import Foundation

// Locale + country
extension Locale {
    public func country(forRegionCode code: String?) -> String {
        guard let code = code else { return "-" }
        return self.localizedString(forRegionCode: code) ?? "-"
    }
    
    public func country(forLanguageCode code: String?) -> String {
        guard let code = code else { return "-" }
        return self.localizedString(forLanguageCode: code) ?? "-"
    }
}
