//
//  PageLayout.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import Foundation

enum PageLayout: Int, Pickable {
    var id: Self { self }
    
    var description: String {
        switch self {
        case .singlePage: return "Single Page"
        case .doublePage: return "Double Page"
        case .automatic:  return "Automatic"
        }
    }
    
    case singlePage, doublePage, automatic
}
