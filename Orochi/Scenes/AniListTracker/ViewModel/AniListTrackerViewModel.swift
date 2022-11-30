//
//  AniListTrackerViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI

class AniListTrackerViewModel: ObservableObject {
    @Published var status: AniListStatus = .wantTo
    @Published var startDate: Date = .now
    @Published var endDate: Date = .now
    @Published var showScorePicker: Bool = false
    @Published var showVolumePicker: Bool = false
    @Published var showChapterPicker: Bool = false
    @Published var chapter: Double = 0
    @Published var score: Double = 0
    @Published var volume: Double = 0
    @Published var sheetHeight: CGFloat = UIScreen.height
}
