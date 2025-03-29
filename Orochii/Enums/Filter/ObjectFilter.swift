//
//  ObjectFilter.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Object that will be considerated when you filter some mangas
enum ObjectFilter: Int, Pickable {
    var id: Self { self }
    
    case name, lastUpdated, releaseYear
    
    /// Object filter decription
    var description: String {
        switch self {
        case .name:        return L10n.filterName
        case .lastUpdated: return L10n.filterLastUpdated
        case .releaseYear: return L10n.filterReleaseYear
        }
    }
}
