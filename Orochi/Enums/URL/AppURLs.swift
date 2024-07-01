//
//  AppURLs.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import Foundation

/// All URLs used in App
enum AppURLs: CustomStringConvertible {
    case alSite, mdSite, gitHub
    /// URL
    var description: String {
        switch self {
        case .alSite: return "https://anilist.co"
        case .mdSite: return "https://mangadex.org"
        case .gitHub: return "https://github.com/douglazhs/Orochii"
        }
    }
}
