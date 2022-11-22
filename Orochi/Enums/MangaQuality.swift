//
//  MangaQuality.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Manga image quality
enum MangaQuality: CaseIterable {
    case low, medium, high
    
    /// Manga quality ID
    var name: String {
        switch self {
        case .low:    return String.MangaSource.lowQuality
        case .medium: return String.MangaSource.mediumQuality
        case .high:   return String.MangaSource.highQuality
        }
    }
}
