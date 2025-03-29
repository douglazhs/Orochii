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
        case .planning: return L10n.mangaStatusPlanning
        case .reading: return L10n.mangaStartReading
        case .completed: return L10n.mangaStatusCompleted
        case .rereading: return L10n.mangaStatusRereading
        case .paused: return L10n.mangaStatusPaused
        case .dropped: return L10n.mangaStatusDropped
        case .none: return L10n.mangaStatusNone
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
