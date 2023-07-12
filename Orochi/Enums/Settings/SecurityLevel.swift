//
//  SecurityLevel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import Foundation

/// Face ID level protection
enum SecurityLevel: Int, Pickable {
    var id: Self { self }
    
    case library, app
    
    /// Security level description
    var description: String {
        switch self {
        case .library: return String.Adjusts.securityLibrary
        case .app:     return "App"
        }
    }
    
    /// Level information, such as name and icon
    var info: (String, String) {
        switch self {
        case .library: return (
            "books.vertical",
            String.Adjusts.libraryFooter
        )
        case .app: return (
            "house",
            String.Adjusts.appFooter
        )
        }
    }
}
