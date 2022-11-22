//
//  Actions.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import Foundation

/// Button actions
enum Actions: CaseIterable {
    case addLib, aniList, rmvLib
    
    /// Action ID
    var name: String {
        switch self {
        case .addLib:  return String.Common.add
        case .rmvLib:  return String.Common.remove
        case .aniList: return "ANILIST"
        }
    }
}
