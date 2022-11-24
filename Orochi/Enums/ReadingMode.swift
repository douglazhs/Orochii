//
//  ReadingMode.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import Foundation

enum ReadingMode: Pickable {
    var id: Self { self }
    
    var description: String {
        switch self {
        case .defaultMode:    return "Default"
        case .leftToRight:    return "Left to Right"
        case .rightToLeft:    return "Right to Left"
        case .vertical:       return "Vertical"
        case .verticalScroll: return "Vertical Scroll"
        }
    }
    
    case defaultMode, leftToRight, rightToLeft, vertical, verticalScroll
}
