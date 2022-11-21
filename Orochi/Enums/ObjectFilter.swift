//
//  ObjectFilter.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Object that will be considerated when you filter some mangas
enum ObjectFilter: CaseIterable {
    case name, lastUpdated, releaseYear
    
    /// Object filter ID
    var name: String {
        switch self {
        case .name:        return String.Filter.name
        case .lastUpdated: return String.Filter.lastUpdated
        case .releaseYear: return String.Filter.releaseYear
        }
    }
}
