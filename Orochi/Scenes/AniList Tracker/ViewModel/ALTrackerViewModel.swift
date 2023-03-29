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
    
    var description: String {
        switch self {
        case .score:   return "Score"
        case .chapter: return "Ch."
        case .volume:  return "Vol."
        }
    }
}

class ALTrackerViewModel: ObservableObject {
    @Published var currentPicker: ALPicker = .chapter
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
