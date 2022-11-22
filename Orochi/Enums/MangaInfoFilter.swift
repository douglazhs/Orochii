//
//  MangaInfoFilter.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Manga informations that help on user filtering
enum MangaInfoFilter: CaseIterable {
    case language, year, demoPublic, status
    
    /// Manga information ID
    var name: String {
        switch self {
        case .language:   return String.Filter.language
        case .year:       return String.Filter.year
        case .demoPublic: return String.Filter.demoPublic
        case .status:     return String.Filter.status
        }
    }
}
