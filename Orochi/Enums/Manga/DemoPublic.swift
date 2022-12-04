//
//  DemoPublic.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Demographic public
enum DemoPublic: Pickable {
    var id: Self { self }
    
    case seinen, shounen
    
    /// Demographic public description
    var description: String {
        switch self {
        case .seinen: return  "Shounen"
        case .shounen: return "Seinen"
        }
    }
}
