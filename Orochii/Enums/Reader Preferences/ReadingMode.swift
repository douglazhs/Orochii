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
        case .defaultMode:    return L.Reader.Mode.default
        case .leftToRight:    return L.Reader.Mode.leftToRight
        case .rightToLeft:    return L.Reader.Mode.rightToLeft
        case .webtoon:        return L.Reader.Mode.webtoon
        }
    }
    
    case defaultMode, leftToRight, rightToLeft, webtoon
}
