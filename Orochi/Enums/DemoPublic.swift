//
//  DemoPublic.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Demographic public
enum DemoPublic: CaseIterable {
    case seinen, shounen
    
    /// Demographic public ID
    var name: String {
        switch self {
        case .seinen: return  "Shounen"
        case .shounen: return "Seinen"
        }
    }
}
