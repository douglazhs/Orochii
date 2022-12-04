//
//  HistoryViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

class HistoryViewModel: ObservableObject {
    @Published var query: String = ""
    @Published var truncated: Bool = false
    @Published var action: Bool = false
}
