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
        case .large: return L.MangaSource.Anilist.Cover.large
        case .medium: return L.MangaSource.Anilist.Cover.medium
        case .extraLarge: return  L.MangaSource.Anilist.Cover.extraLarge
        }
    }
}

/// MangaDex cover quality. `low`= 256px `medium` = 512px
public enum MangaDexCoverQuality: Int, Pickable {
    case original, medium, low
    
    public var id: Self { self }
    
    public var description: String {
        switch self {
        case .low: return L.MangaSource.Mdex.Cover.low
        case .medium: return L.MangaSource.Mdex.Cover.medium
        case .original: return L.MangaSource.Mdex.Cover.original
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
