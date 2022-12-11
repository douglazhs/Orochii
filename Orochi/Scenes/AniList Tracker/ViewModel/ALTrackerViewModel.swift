//
//  ALTrackerViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI

/// AniList button field
enum ALPicker {
    case score, chapter, volume
}

/// Current manga context
enum CurrentContext: Pickable {
    var id: Self { self }
    case states, dates, score
    
    var description: String {
        switch self {
        case .dates:  return "Dates"
        case .states: return "States"
        case .score:  return "Score"
        }
    }
}

class ALTrackerViewModel: ObservableObject {
    @Published var currentPicker: ALPicker = .chapter
    @Published var status: ALStatus = .wantTo
    @Published var currentContext: CurrentContext = .states
    @Published var startDate: Date = .now
    @Published var endDate: Date = .now
    @Published var showScorePicker: Bool = false
    @Published var showVolumePicker: Bool = false
    @Published var showChapterPicker: Bool = false
    @Published var showPickers: Bool = false
    @Published var chapter: Double = 0
    @Published var score: Double = 0
    @Published var volume: Double = 0
}
