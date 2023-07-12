//
//  SourcePreferencesViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 12/07/23.
//

import Foundation

class SourcePreferencesViewModel: ObservableObject {
    @Published var selectedQuality: MangaQuality = .medium
    @Published var nsfw: Bool = false
    @Published var languages: [Language] = []
    
    init() {
        loadDefaults()
    }
    
    /// Load user defaults
    func loadDefaults() {
        let rawValues = Defaults.standard.getObj(of: DefaultsKeys.SrcPreferences.languages.rawValue) as? [Int] ?? []
        languages = rawValues.map { Language(rawValue: $0) ?? .enUS }
        selectedQuality = MangaQuality(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.SrcPreferences.quality.rawValue)
        ) ?? .medium
        nsfw = Defaults.standard.getBool(of: DefaultsKeys.SrcPreferences.nsfw.rawValue)
    }
}
