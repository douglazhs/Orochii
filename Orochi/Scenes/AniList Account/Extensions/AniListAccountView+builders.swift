//
//  AniListAccountView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI
import AniListService

extension AniListAccountView {
    @ViewBuilder
    func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                self.statsCell()
                self.tabs()
            }
        }
        .refreshable { Task { await vm.refresh() } }
        .background(BlurBackground(with: .view_background))
        .scrollContentBackground(.hidden)
        .listStyle(.grouped)
    }
    
    /// Following and followers area
    @ViewBuilder
    func tabs() -> some View {
        VStack(alignment: .leading) {
            EnumPicker("", selection: $vm.selection)
                .pickerStyle(.segmented)
                .padding(.horizontal)
            switch vm.selection {
            case .general:   self.general()
            case .stats:     self.chartStats()
            case .following: self.followTab(users: vm.following)
            case .followers: self.followTab(users: vm.followers)
            }
        }
    }

    /// Button to see the profile on the web browser
    @ViewBuilder
    func profileWeb() -> some View {
        Button {
            UIApplication.shared
                .safariVC(url: vm.user?.siteUrl ?? "")
        } label: { Image(systemName: "safari") }
    }
}
