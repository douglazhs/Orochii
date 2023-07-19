//
//  MangaActions.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import Foundation

/// Button actions
enum MangaActions: CaseIterable, CustomStringConvertible {
    static var allCases: [MangaActions] = []
    
    case lib, aniList, history(clear: Bool)
    
    /// Action ID
    var description: String {
        switch self {
        case .lib:     return "Library"
        case .aniList: return "Anilist"
        case .history: return "Clear"
        }
    }
}
