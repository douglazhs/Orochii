//
//  Carousel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/08/23.
//

import Foundation
import struct MangaDex.Manga

/// Section carousel
struct Carousel {
    let config: CarouselSection
    var mangas: [Manga]?
    /// Curent section request offset
    var offset: Int = 0
    
    
    /// Section carousel
    /// - Parameters:
    ///   - section: Section configuration
    ///   - mangas: Mangas of section
    init(_ config: CarouselSection, mangas: [Manga]? = nil) {
        self.config = config
        self.mangas = mangas
    }
}
