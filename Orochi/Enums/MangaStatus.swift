//
//  MangaStatus.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Actual manga status
enum MangaStatus: Pickable {
    var id: Self { self }
    
    case ongoing, hiatus, completed
    
    /// Manga status description
    var description: String {
        switch self {
        case .ongoing:   return String.Discovery.ongoing
        case .hiatus:    return String.Discovery.hiatus
        case .completed: return String.Discovery.completed
        }
    }
    
    /// Manga status configuration
    var config: (color: Color, icon: String) {
        switch self {
        case .ongoing:   return (color: Color("ongoing"),   icon: "clock")
        case .hiatus:    return (color: Color("hiatus"),    icon: "stopwatch")
        case .completed: return (color: Color("completed"), icon: "checkmark.circle")
        }
    }
}
