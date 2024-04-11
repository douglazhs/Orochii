//
//  MangaStatus.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import Foundation

/// Local and AniList manga status
enum MangaStatus: String, Pickable {
    var id: Self { self}
    
    case reading = "CURRENT",
        completed = "COMPLETED",
        planning = "PLANNING",
        rereading = "REPEATING",
        paused = "PAUSED",
        dropped = "DROPPED",
        none = "NONE"
    
    /// Status description
    var description: String {
        switch self {
        case .planning: return "Planning"
        case .reading: return "Reading"
        case .completed: return "Completed"
        case .rereading: return "Rereading"
        case .paused: return "Paused"
        case .dropped: return "Dropped"
        case .none: return "None"
        }
    }
    
    /// Status related icon
    var icon: String {
        switch self {
        case .reading: return "popcorn.fill"
        case .completed: return "balloon.fill"
        case .planning: return "clock"
        case .rereading: return "goforward"
        case .paused: return "pause.fill"
        case .dropped: return "stop.fill"
        case .none: return "minus"
        }
    }
}
