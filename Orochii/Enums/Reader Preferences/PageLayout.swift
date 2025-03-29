//
//  PageLayout.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import Foundation

/// Page reader layout
enum PageLayout: Int, Pickable {
    var id: Self { self }
    
    var description: String {
        switch self {
        case .singlePage: return L10n.readerSinglePage
        case .doublePage: return L10n.readerDoublePage
        case .automatic:  return L10n.readerAutomaticPage
        }
    }
    
    case singlePage, doublePage, automatic
}
