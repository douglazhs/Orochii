//
//  ALTrackerViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI

/// AniList button field
enum ALPicker {
    case status, score, chapter, volume
}

class ALTrackerViewModel: ObservableObject {
    @Published var currentPicker: ALPicker = .status
    @Published var status: ALStatus = .wantTo
    @Published var startDate: Date = .now
    @Published var endDate: Date = .now
    @Published var showAlert: Bool = false
    @Published var showPickers: Bool = false
    @Published var chapter: Double = 0
    @Published var score: Double = 0
    @Published var volume: Double = 0
    var height: CGFloat = UIScreen.height
}
