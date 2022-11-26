//
//  MangaActions.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import Foundation

/// Button actions
enum MangaActions: CaseIterable, CustomStringConvertible {
    case addLib, aniList, rmvLib
    
    /// Action ID
    var description: String {
        switch self {
        case .addLib:  return String.Manga.addToLibrary.uppercased()
        case .rmvLib:  return String.Common.remove.uppercased()
        case .aniList: return "ANILIST"
        }
    }
}
