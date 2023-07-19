//
//  MangaQuality.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Manga image quality
enum MangaQuality: Int, Pickable {
    var id: Self { self }
    
    case original, dataSaver
    
    /// Manga quality ID
    var description: String {
        switch self {
        case .original:  return "Original"
        case .dataSaver: return "Data Saver"
        }
    }
}
