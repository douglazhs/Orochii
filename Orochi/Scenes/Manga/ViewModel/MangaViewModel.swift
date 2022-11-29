//
//  MangaViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

let mockLanguages: [Int : String] = [
    0: "en-US",
    1: "pt-BR",
    2: "es-SP"
]

class MangaViewModel: ObservableObject {
    @Published var titleLang: Int = 0
    @Published var descLang: Int = 1
    @Published var mangaOnLib: Bool = false
    @Published var selectAll: Bool = false
    @Published var selection = Set<UUID>()
    @Published var isEditingMode: Bool = false
    @Published var showBottomBar: Bool = false
    @Published var showAniList: Bool = false
    @Published var chaptersOrder: FilterOrder = .ascending
    @Published var btnAction: MangaActions?
    @Published var queryFilter: String = ""
    @Published var search: Bool = false
}
