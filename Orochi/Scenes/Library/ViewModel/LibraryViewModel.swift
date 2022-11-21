//
//  LibraryViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

class LibraryViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var objectFilter: ObjectFilter = .name
    @Published var filterOrder: FilterOrder = .empty
    @Published var languageSelection: Language = .enUS
    @Published var statusSelection: MangaStatus = .ongoing
    @Published var yearSelection: Int = 2000
    @Published var demoPublicSelection: DemoPublic = .shounen
}
