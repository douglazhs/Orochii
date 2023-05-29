//
//  AppURLs.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import Foundation

/// All URLs used in App
enum AppURLs: CustomStringConvertible {
    case ALSite, MDSite
    
    /// URL
    var description: String {
        switch self {
        case .ALSite: return "https://anilist.co/home"
        case .MDSite: return "https://mangadex.org"
        }
    }
}
