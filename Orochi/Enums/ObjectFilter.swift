//
//  ObjectFilter.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Object that will be considerated when you filter some mangas
enum ObjectFilter: Pickable {
    var id: Self { self }
    
    case name, lastUpdated, releaseYear
    
    /// Object filter decription
    var description: String {
        switch self {
        case .name:        return String.Filter.name
        case .lastUpdated: return String.Filter.lastUpdated
        case .releaseYear: return String.Filter.releaseYear
        }
    }
}
