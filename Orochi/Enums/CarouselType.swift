//
//  CarouselType.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import Foundation

/// Carousel type
enum CarouselType: Int, CaseIterable {
    case latestUploaded, mostRelevants, ongoingStatus, thisYear, shounen, seinen
    
    /// Carousel header
    var header: String {
        switch self {
        case .latestUploaded: return "Latest Uploaded"
        case .mostRelevants:  return "Most Relevants"
        case .ongoingStatus:  return "Ongoing now"
        case .thisYear:       return "This Year - \(Date.now.formatted(.dateTime.year()))"
        case .shounen:        return "Shounen Public"
        case .seinen:         return "Seinen Public"
        }
    }
}
