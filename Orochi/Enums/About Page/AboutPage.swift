//
//  AboutPage.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/23.
//

import Foundation

/// About section page
enum AboutPage: Pickable {
    var id: Self { self }
    
    case about, version
    
    var description: String {
        switch self {
        case .about:   return "About"
        case .version: return "Version"
        }
    }
}
