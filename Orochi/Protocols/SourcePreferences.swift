//
//  SourcePreferences.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/07/23.
//

import Foundation

/// Source request preferences
protocol SourcePreferences {
    /// Default params based on user source preferences
    /// - Returns: Params dictionary
    func defaults() -> [String : Any]
    
    /// Merge two dictionaries
    /// - Parameters:
    ///   - dictOne: Base dictionary
    ///   - dictTwo: Dictionary to be merged into dictOne
    func merge(_ dictOne : [String : Any], into dictTwo: [String : Any]) -> [String : Any]
}

extension SourcePreferences {
    func defaults() -> [String : Any] {
        guard let langs = Defaults.standard.getObj(
            of: DefaultsKeys.SrcPreferences.languages.rawValue
        ) as? [Int] else { return [:] }
        
        let defaultLangs = langs.map {
            (Language(rawValue: $0) ?? .enUS).apiId
        }
        let nsfw = Defaults.standard.getBool(
            of: DefaultsKeys.SrcPreferences.nsfw.rawValue
        )
        
        var translatedLangs: [String : Any] = [:]
        translatedLangs["availableTranslatedLanguage[]"] = defaultLangs
        
        var contentRating: [String : Any] = [:]
        if nsfw {
            contentRating["contentRating[]"] = [
                "safe",
                "pornographic",
                "erotica",
                "suggestive"
            ]
        }
        contentRating["contentRating[]"] = [
            "safe",
            "suggestive"
        ]
        
        return merge(
            contentRating,
            into: translatedLangs
        )
    }
    
    func merge(
        _ dictOne: [String : Any],
        into dictTwo: [String : Any]
    ) -> [String : Any] {
        dictOne.merging(dictTwo) { first, _ in first }
    }
}
