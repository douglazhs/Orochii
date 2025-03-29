//
//  MainFilter.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import Foundation

/// Main home screen content
enum MainFilter: Int, CaseIterable {
    case mostRelevants, awardWinning, thisYear, shounen, seinen, webComic
    
    /// Carousel header
    var header: String {
        switch self {
        case .mostRelevants:  return L10n.discoveryMostRelevants
        case .awardWinning:   return L10n.discoveryAwardWinning
        case .thisYear:       return L10n.discoveryThisYear(Date.now.formatted(.dateTime.year()))
        case .shounen:        return L10n.discoveryShounen
        case .seinen:         return L10n.discoverySeinen
        case .webComic:       return L10n.discoveryWebcomics
        }
    }
    
    /// Request params merged with the user defaults parameters
    var params: [String: Any] {
        return sectionParams()
    }
}

/// Main home screen parameters
extension MainFilter {
    /// Parameters for request according to the main filter
    /// - Returns: Main filter parameters
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
