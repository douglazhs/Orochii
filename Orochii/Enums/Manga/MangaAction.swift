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
            case .changeFolder: return L10n.mangaSubActionMoved
            case .remove: return L10n.mangaSubActionRemoved
            }
        }
    }
    
    static var allCases: [MangaAction] = []
    
    case lib(SubAction), aniList
    
    /// Action ID
    var description: String {
        switch self {
        case .lib:     return L10n.mangaActionLibrary
        case .aniList: return L10n.mangaActionAnilist
        }
    }
}
