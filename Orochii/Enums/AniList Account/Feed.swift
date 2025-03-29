//
//  Feed.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 18/04/24.
//

import Foundation

/// AniList user feed
enum Feed: Pickable {
    var id: Self { self }
    
    case mine, following
    
    /// Current feed title
    var description: String {
        switch self {
        case .mine: return L10n.accountFeedMine
        case .following: return L10n.accountFeedFollowing
        }
    }
    
    /// Current feed icon
    var icon: String {
        switch self {
        case .mine: return "person"
        case .following: return "person.3"
        }
    }
}
