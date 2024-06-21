//
//  CharacterView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/06/24.
//

import SwiftUI

import struct AniListService.Character
import struct AniListService.CharacterMock

struct CharacterView: View {
    @EnvironmentObject var vm: ALAccountViewModel
    var character: Character
    var summaryHiddenSpoilers: String = ""
    @State var showSummarySpoiler: Bool = false
    @State var showTitlesSpoiler: Bool = false
    
    init(_ character: Character) {
        self.character = character
        self.summaryHiddenSpoilers = getSpoilers()
    }
    
    var body: some View {
        NavigationStack {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(buildName())
                .toolbarRole(.editor)
        }
    }
    
    /// Build character name starting with Its last name
    func buildName() -> String {
        var fullName = [String?]()
        fullName.append(
            contentsOf: [
                character.name?.first,
                character.name?.middle,
                character.name?.last
            ]
        )
        guard !fullName.isEmpty, character.name?.first != nil else {
            return character.name?.full ?? String.Common.unknown
        }
        return fullName.compactMap { $0 }.joined(separator: " ")
    }
    
    func getSpoilers() -> String {
        guard var summary = character.description else { return String.Common.none }
        
        while summary.contains("~!") {
            summary = summary.replaced(
                from: "~!",
                to: "!~",
                by: "Spoiler"
            )
        }
        return summary
    }
    
    var summaryHaveSpoiler: Bool {
        guard let summary = character.description else { return false }
        if summary.contains("~!") { return true }
        return false
    }
    
    var haveAlternativeTitles: Bool {
        return !(character.name?.alternative?.isEmpty ?? true)
        || !(character.name?.alternativeSpoiler?.isEmpty ?? true)
    }
}

#Preview {
    CharacterView(CharacterMock.character)
}
