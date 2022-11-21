//
//  DiscoverViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

/// Carousel type
enum CarouselType: CaseIterable {
    case latestUploaded, mostRelevants, ongoingStatus, thisYear, shounen, seinen
    var mangas: [MangaDomain] {
        get { [] }
        set { }
    }
    
    /// Carousel header
    var header: String {
        switch self {
        case .latestUploaded:
            return "Latest Uploaded"
        case .mostRelevants:
            return "Most Relevants"
        case .ongoingStatus:
            return "Ongoing now"
        case .thisYear:
            return "This Year - \(Date.now.formatted(.dateTime.year()))"
        case .shounen:
            return "Shounen Demographic Public"
        case .seinen:
            return "Seinen Demographic Public"
        }
    }
}

class DiscoverViewModel: ObservableObject {
    @Published var searchText: String = ""
    // TODO: - Change all to api requests
    @Published var mangas: [MangaDomain] = samples
    @Published var latestUploaded: [MangaDomain] = samples
    @Published var moreRelevants: [MangaDomain] = samples
    @Published var ongoingStatus: [MangaDomain] = samples
    @Published var thisYear: [MangaDomain] = samples
    @Published var shounen: [MangaDomain] = samples
    @Published var seinen: [MangaDomain] = samples
}

