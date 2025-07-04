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
        case .singlePage: return L.Reader.Layout.singlePage
        case .doublePage: return L.Reader.Layout.doublePage
        case .automatic:  return L.Reader.Layout.automatic
        }
    }
    
    case singlePage, doublePage, automatic
}
