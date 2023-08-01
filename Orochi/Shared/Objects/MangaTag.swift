//
//  MangaTag.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/08/23.
//

import SwiftUI

/// Manga tag
struct MangaTag: Identifiable {
    let id = UUID()
    
    enum Tag {
        case format, contentRating(Main), content
    }
    
    enum Main: String {
        case safe, suggestive, erotica, pornographic
        
        var color: Color {
            switch self {
            case .safe: return Color(.systemGreen)
            case .suggestive: return Color(.systemOrange)
            case .erotica: return Color(.systemIndigo)
            case .pornographic: return Color(.systemRed)
            }
        }
    }
    
    let tag: Tag
    let title: String
    var color: Color {
        switch tag {
        case .contentRating(let rating): return rating.color
        case .content: return Color(.systemRed)
        case .format: return .accentColor
        }
    }
    
    init(title: String, _ tag: Tag) {
        self.title = title
        self.tag = tag
    }
}
