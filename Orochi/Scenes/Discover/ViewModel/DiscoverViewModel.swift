//
//  DiscoverViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

/// Carousel Dictionary Configuration
typealias CarouselDict = [CarouselType : [MangaDomain]]

class DiscoverViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var section: CarouselDict = [:]
    
    init() {
        self.section = generateCarouselDict()
    }
    
    /// Generate Main screen carousel dictionary
    /// - Returns: All main view carousel
    func generateCarouselDict() -> CarouselDict {
        var dict: CarouselDict = [:]
        CarouselType.allCases.forEach { type in
            dict[type] = MangaDomain.samples
        }
        return dict
    }
}
