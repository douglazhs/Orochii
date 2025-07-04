//
//  DiscoverFilterViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 06/06/24.
//

import SwiftUI

struct Tree<Value: Hashable>: Hashable, Identifiable {
    let id = UUID()
    let value: Value
    var children: [Tree]?
}

enum FilterSelection: CaseIterable {
    case originalLanguage, demographic, contentRating, status, sort, contents
    
    var description: String {
        switch self {
        case .originalLanguage: return "Original Language"
        case .demographic: return "Demographic"
        case .contentRating: return "Content Rating"
        case .status: return "Status"
        case .sort: return "Sort"
        case .contents: return "Contents"
        }
    }
}

final class DiscoverFilterViewModel: ObservableObject {
    let categories: [Tree<String>] = FilterSelection
        .allCases
        .compactMap { Tree(value: $0.description) }
}
