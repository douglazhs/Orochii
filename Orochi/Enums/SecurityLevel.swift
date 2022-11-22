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
    var info: (String, String, String) {
        switch self {
        case .library: return (
            String.Adjusts.securityLibrary,
            "books.vertical",
            String.Adjusts.libraryFooter
        )
        case .app: return (
            "App",
            "house",
            String.Adjusts.appFooter
        )
        }
    }
}
