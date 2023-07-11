//
//  MangaStatus.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Actual manga status
enum MangaStatus: String, Pickable {
    var id: Self { self }
    
    case current, planning, completed, dropped, paused, repeating
    
    /// Manga status description
    var description: String {
        switch self {
        case .current:   return "READING"
        case .planning:  return "PLANNING"
        case .completed: return "COMPLETED"
        case .dropped:   return "DROPPED"
        case .paused:    return "PAUSED"
        case .repeating: return "REPEATING"
        }
    }
}
