//
//  ReadingMode.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import Foundation

/// Reading mode
enum ReadingMode: Int, Pickable {
    var id: Self { self }
    
    var description: String {
        switch self {
        case .defaultMode:    return L10n.readerDefaultMode
        case .leftToRight:    return L10n.readerLeftToRightMode
        case .rightToLeft:    return L10n.readerRightToLeftMode
        case .webtoon:        return L10n.readerWebtoonMode
        }
    }
    
    case defaultMode, leftToRight, rightToLeft, webtoon
}
