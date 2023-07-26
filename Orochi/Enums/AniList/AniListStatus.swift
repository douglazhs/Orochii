//
//  AniListStatus.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import Foundation

/// Manga AniList status
enum ALStatus: String, Pickable {
    var id:  Self { self}
    
    case reading = "CURRENT",
         completed = "COMPLETED",
         planning = "PLANNING",
         rereading = "REPEATING",
         paused = "PAUSED",
         dropped = "DROPPED"
    
    /// Status description
    var description: String {
        switch self {
        case .planning:    return "Planning"
        case .reading:   return "Reading"
        case .completed: return "Completed"
        case .rereading: return "Rereading"
        case .paused:    return "Paused"
        case .dropped:   return "Dropped"
        }
    }
}
