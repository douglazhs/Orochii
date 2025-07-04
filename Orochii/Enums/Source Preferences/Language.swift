//
//  Language.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Manga search languages
enum Language: Int, Pickable {
    var id: Self { self }
    
    case ptBr, enUS
    
    var description: String {
        switch self {
        case .ptBr: return L.Language.portuguese
        case .enUS: return L.Language.english
        }
    }
    
    var apiId: String {
        switch self {
        case .ptBr: return "pt-br"
        case .enUS: return "en"
        }
    }
}
