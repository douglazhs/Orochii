//
//  CoverQuality.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/24.
//

import Foundation

/// MangaDex cover quality. `.low`= 256px `.medium` = 512px
public enum CoverQuality: Int, Pickable {
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
