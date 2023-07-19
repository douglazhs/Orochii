//
//  Carousel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import Foundation

/// Carousel type
enum Carousel: Int, CaseIterable {
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
    
    /// Request params merged with the user defaults parameters
    var params: [String: Any] {
        return sectionParams().merging(defaults()) { first, _ in first }
    }
}

// Carousel parameters
extension Carousel {
    /// Carousel parameters for request
    /// - Returns: Section parameters
    func sectionParams() -> [String : Any] {
        var defaultParams: [String : Any] = [
            "limit" : 20,
            "order[rating]" : "desc"
        ]
        switch self {
        case .latestUploaded: defaultParams["order[latestUploadedChapter]"] = "desc"
        case .mostRelevants: defaultParams["order[followedCount]"] = "desc"
        case .ongoingStatus: defaultParams ["status[]"] = "ongoing"
        case .thisYear: defaultParams["year"] = Date.now.formatted(.dateTime.year())
        case .shounen: defaultParams["publicationDemographic[]"] = "shounen"
        case .seinen: defaultParams["publicationDemographic[]"] = "seinen"
        }
        return defaultParams
    }
    /// Load manga preferences from user defaults
    /// - Returns: Preferences dictionary
    func defaults() -> [String : Any] {
        guard let langs = Defaults.standard.getObj(
            of: DefaultsKeys.SrcPreferences.languages.rawValue
        ) as? [Int] else { return [:] }
        
        let defaultLangs = langs.map { (Language(rawValue: $0) ?? .enUS).apiId }
        let nsfw = Defaults.standard.getBool(of: DefaultsKeys.SrcPreferences.nsfw.rawValue)
        
        var translatedLangs: [String : Any] = [:]
        translatedLangs["availableTranslatedLanguage[]"] = defaultLangs
        
        var contentRating: [String : Any] = [:]
        if nsfw {
            contentRating["contentRating[]"] = ["safe", "pornographic", "erotica", "suggestive"]
        }
        contentRating["contentRating[]"] = ["safe", "suggestive"]
        
        return contentRating.merging(translatedLangs) { _, first in first}
    }
}
