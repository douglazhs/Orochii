//
//  MangaViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

class MangaViewModel: ObservableObject {
    @Published var titleLang: String = "en-Us"
    @Published var descLang: String = "en-US"
    @Published var mangaOnLib: Bool = false
    @Published var ascending: Bool = false
    @Published var btnAction: MangaActions?
}
