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
        case .stats: return L.Account.Tab.stats
        case .activity: return L.Account.Tab.activity
        case .favorites: return L.Account.Tab.favorites
        }
    }
}
