//
//  MangaActions.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import Foundation

/// Button actions
enum MangaActions: CaseIterable, CustomStringConvertible {
    case addLib, aniList, rmvLib, history
    
    /// Action ID
    var description: String {
        switch self {
        case .addLib:       return String.Manga.addToLibrary.uppercased()
        case .rmvLib:       return String.Common.remove.uppercased()
        case .aniList:      return "ANILIST"
        case .history:      return "Clear"
        }
    }
    
    /// Action message
    var message: String {
        switch self {
        case .addLib:       return "Successfully added "
        case .aniList:      return "Successfully updated"
        case .rmvLib:       return "Successfully removed"
        case .history:      return "Successfully cleared history"
        }
    }
}
