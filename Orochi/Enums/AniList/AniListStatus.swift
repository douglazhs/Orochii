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
    
    case reading, completed, wantTo, rereading, paused, dropped
    
    /// Status description
    var description: String {
        switch self {
        case .wantTo:    return "Want to read"
        case .reading:   return "Reading"
        case .completed: return "Completed"
        case .rereading: return "Rereading"
        case .paused:    return "Paused"
        case .dropped:   return "Dropped"
        }
    }
}
