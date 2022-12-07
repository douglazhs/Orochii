//
//  MangaViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

class MangaViewModel: ObservableObject {
    @Published var descLang: Int = 1
    @Published var mangaOnLib: Bool = false
    @Published var selectAll: Bool = false
    @Published var occurredAct: Bool = false
    @Published var selection = Set<UUID>()
    @Published var isEditingMode: Bool = false
    @Published var showBottomBar: Bool = false
    @Published var showHistory: Bool = false
    @Published var showAniList: Bool = false
    @Published var downloaded: Bool = false
    @Published var chaptersOrder: OrderFilter = .ascending
    @Published var btnAction: MangaActions?
    @Published var queryFilter: String = ""
    @Published var search: Bool = false
    @Published var actionMessage: String = ""
    
    /// Start action when a button is pressed
    /// - Parameter action: Actual action
    func startAction(for action: MangaActions) {
        btnAction = action
        switch action {
        case .aniList: anilistHandler()
        case .history(let clear): historyHandler(clear)
        case .lib: mangaOnLib ? removeFromLib() : addToLib()
        }
        buildPopUp()
    }
    
    /// Add manga to library
    private func addToLib() {
        withAnimation(.linear(duration: 0.175)) {
            occurredAct = true
        }
        mangaOnLib = true
        Haptics.shared.notify(.success)
    }
    
    /// Remove manga from library
    private func removeFromLib() {
        withAnimation(.linear(duration: 0.175)) {
            occurredAct = true
        }
        mangaOnLib = false
        Haptics.shared.notify(.error)
    }
    
    /// History actions
    /// - Parameter clear: clear or not the history
    private func historyHandler(_ clear: Bool) {
        if !clear {
            showHistory = true
        } else {
            clearHistory()
        }
    }
    
    /// Clear manga history
    private func clearHistory() {
        withAnimation(.linear(duration: 0.175)) {
            occurredAct = true
        }
        Haptics.shared.notify(.error)
    }
    
    /// Anilist update action
    private func anilistHandler() {
        showAniList = true
    }
    
    /// Build pop up message
    func buildPopUp() {
        switch btnAction {
        case .lib:
            actionMessage = mangaOnLib ? "Successfully Added" : "Successfully Removed"
        case .aniList:
            actionMessage = "Successfully Updated"
        case .history:
            actionMessage = "Successfully Cleared"
        default: break
        }
    }
}
