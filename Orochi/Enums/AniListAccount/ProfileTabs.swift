//
//  ProfileTabs.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import Foundation

/// Profile tabs
enum ProfileTabs: Pickable {
    var id:  Self { self}
    
    case general, stats, following, followers
    
    var description: String {
        switch self {
        case .general:   return "General"
        case .stats:     return "Stats"
        case .following: return "Following"
        case .followers: return "Followers"
        }
    }
}
