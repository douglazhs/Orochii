//
//  LibraryViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

class LibraryViewModel: ObservableObject {
    let years = Array<Int>(stride(from: 2000, through: 2022, by: 1))
    @Published var query: String = ""
    @Published var objectFilter: ObjectFilter = .name
    @Published var filterOrder: OrderFilter = .ascending
    @Published var languageSelection: Language = .enUS
    @Published var yearSelection: Int = 2000
    @Published var demoPublicSelection: DemoPublic = .shounen
}
