//
//  ALTab.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import Foundation

/// AniList account current tab
enum ALTab: Int, CaseIterable {
    case stats, activity, favorites

    /// Localized tab title
    var title: String {
        switch self {
        case .stats: return String.Account.stats
        case .activity: return String.Account.activity
        case .favorites: return String.Account.favorites
        }
    }
}
