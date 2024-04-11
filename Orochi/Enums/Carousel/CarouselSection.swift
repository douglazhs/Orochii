//
//  CarouselSection.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import Foundation

/// Carousel type
enum CarouselSection: Int, CaseIterable {
    case mostRelevants, awardWinning, thisYear, shounen, seinen, webComic
    
    /// Carousel header
    var header: String {
        switch self {
        case .mostRelevants:  return "Most Relevants"
        case .awardWinning:   return "Award Winning"
        case .thisYear:       return "This Year - \(Date.now.formatted(.dateTime.year()))"
        case .shounen:        return "Shounen Public"
        case .seinen:         return "Seinen Public"
        case .webComic:       return "Webcomics Full Colored"
        }
    }
    
    /// Request params merged with the user defaults parameters
    var params: [String: Any] {
        return sectionParams()
    }
}

// Carousel parameters
extension CarouselSection {
    /// Carousel parameters for request
    /// - Returns: Section parameters
    func sectionParams() -> [String: Any] {
        var params: [String: Any] = [
            "limit": 30,
            "order[rating]": "desc"
        ]
        switch self {
        case .mostRelevants: params["order[followedCount]"] = "desc"
        case .awardWinning:  params["includedTags[]"] = ["0a39b5a1-b235-4886-a747-1d05d216532d"]
        case .thisYear: params["year"] = Date.now.formatted(.dateTime.year())
        case .shounen: params["publicationDemographic[]"] = "shounen"
        case .seinen: params["publicationDemographic[]"] = "seinen"
        case .webComic: params["includedTags[]"] = [
            "e197df38-d0e7-43b5-9b09-2842d0c326dd",
            "f5ba408b-0e7a-484d-8d49-4e9125ac96de"
        ]
        }
        return params
    }
}
