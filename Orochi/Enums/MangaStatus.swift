//
//  MangaStatus.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Actual manga status
enum MangaStatus: CaseIterable {
    case ongoing, hiatus, completed
    
    /// Manga status configuration
    var config: (name: String, color: Color, icon: String) {
        switch self {
        case .ongoing:   return (name: String.Discovery.ongoing,   color: Color("ongoing"),   icon: "clock")
        case .hiatus:    return (name: String.Discovery.hiatus,    color: Color("hiatus"),    icon: "stopwatch")
        case .completed: return (name: String.Discovery.completed, color: Color("completed"), icon: "checkmark.circle")
        }
    }
}
