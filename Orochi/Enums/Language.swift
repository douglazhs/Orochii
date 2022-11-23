//
//  Language.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Manga search languages
enum Language: Pickable {
    var id: Self { self }
    
    case ptBr, enUS, esES
    
    var description: String {
        switch self {
        case .ptBr: return "Portuguese (Brazil)"
        case .enUS: return "English (U.S.)"
        case .esES: return "Spanish (Spain)"
        }
    }
}
