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
        case .planning: return L.Manga.Status.planning
        case .reading: return L.Manga.Status.reading
        case .completed: return L.Manga.Status.completed
        case .rereading: return L.Manga.Status.rereading
        case .paused: return L.Manga.Status.paused
        case .dropped: return L.Manga.Status.dropped
        case .none: return L.Manga.Status.none
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
