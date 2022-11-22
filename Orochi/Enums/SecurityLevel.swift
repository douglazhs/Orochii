//
//  SecurityLevel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import Foundation

/// Face ID level protection
enum SecurityLevel: CaseIterable {
    case library, app
    
    /// Level information, such as name and icon
    var info: (String, String) {
        switch self {
        case .library: return ("Library", "books.vertical.fill")
        case .app:     return ("App", "house.fill")
        }
    }
}
