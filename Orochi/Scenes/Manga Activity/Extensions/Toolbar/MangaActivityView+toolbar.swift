//
//  MangaActivityView+toolbar.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 03/06/23.
//

import SwiftUI

extension MangaActivityView {
    /// Navigation bar menu
    @ViewBuilder
    func menu() -> some View {
        Menu {
            self.subscribeSection()
            if let activity = vm.activity,
               vm.isCurrent(activity.userId)
            { self.removeSection() }
        } label: { Image(systemName: "ellipsis") }
    }
    
    /// Subscribe section
    @ViewBuilder
    func subscribeSection() -> some View {
        Section {
            Button {
                vm.toggleSubscription()
            } label: {
                Label(
                    vm.activity?.isSubscribed ?? false
                    ? "Unsubscribe"
                    : "Subscribe",
                    systemImage: vm.activity?.isSubscribed ?? false
                    ? "bell.fill"
                    : "bell"
                )
            }
        } header: {
            Text("Receive updates of this activity")
        }
    }
    
    /// Remove activity section
    @ViewBuilder
    func removeSection() -> some View {
        Section {
            Button(role: .destructive) {
                showAlert = true
            } label: {
                Label(String.Common.remove, systemImage: "trash")
            }
        }
    }
}
