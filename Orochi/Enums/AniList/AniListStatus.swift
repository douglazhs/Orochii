//
//  AniListStatus.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import Foundation

/// Manga AniList status
enum ALStatus: Pickable {
    var id:  Self { self}
    
    case completed, reading, wantTo, dropped
    
    /// Status description
    var description: String {
        switch self {
        case .completed: return "Completed"
        case .reading:   return "Reading"
        case .wantTo:    return "Want to read"
        case .dropped:   return "Dropped"
        }
    }
}
