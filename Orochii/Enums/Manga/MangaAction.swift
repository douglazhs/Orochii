//
//  MangaAction.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import Foundation

/// Button actions
enum MangaAction: CaseIterable, CustomStringConvertible {
    enum SubAction: CustomStringConvertible {
        case changeFolder, remove
        
        var description: String {
            switch self {
            case .changeFolder: return L.Manga.SubAction.moved
            case .remove: return L.Manga.SubAction.removed
            }
        }
    }
    
    static var allCases: [MangaAction] = []
    
    case lib(SubAction), aniList
    
    /// Action ID
    var description: String {
        switch self {
        case .lib:     return L.Manga.Action.library
        case .aniList: return L.Manga.Action.anilist
        }
    }
}
