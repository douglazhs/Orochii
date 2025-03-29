//
//  CoverQuality.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/24.
//

import Foundation

/// AniList cover quality.
public enum AniListCoverQuality: Int, Pickable {
    case large, extraLarge, medium
    
    public var id: Self { self }
    
    public var description: String {
        switch self {
        case .large: return "Large"
        case .medium: return "Medium"
        case .extraLarge: return "Extra Large"
        }
    }
}

/// MangaDex cover quality. `low`= 256px `medium` = 512px
public enum MangaDexCoverQuality: Int, Pickable {
    case original, medium, low
    
    public var id: Self { self }
    
    public var description: String {
        switch self {
        case .low: return "Low"
        case .medium: return "Medium"
        case .original: return "Original"
        }
    }
    
    /// Quality key
    public var key: String {
        switch self {
        case .low: return ".256.jpg"
        case .medium: return ".512.jpg"
        case .original: return ""
        }
    }
}
