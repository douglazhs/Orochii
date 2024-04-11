//
//  DiscoveryView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

extension DiscoverView {
    /// Main content
    /// - Returns: Screen variations
    @ViewBuilder 
    func content() -> some View {
        switch viewStyle {
        case .search:
            SearchStyleView($viewStyle).environmentObject(vm)
                .onChange(of: vm.nameQuery) { newValue in
                    if newValue.isEmpty {
                        withTransaction(.init(animation: .easeInOut(duration: 0.185))) {
                            viewStyle = .initial
                        }
                    }
                }
        case .initial:
            InitialStyleView()
                .environmentObject(vm)
                .onChange(of: vm.nameQuery) { newValue in
                    if !newValue.isEmpty {
                        withTransaction(.init(animation: .easeInOut(duration: 0.185).delay(0.5))) {
                            viewStyle = .search
                        }
                    }
                }
        }
    }
    
    /// Manga source preferences
    /// - Returns: Manga source preferences button
    @ViewBuilder
    func mangaSourceButton() -> some View {
        Button { mangaSourcePref = true } label: {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .foregroundColor(.accentColor)
                .fontWeight(.semibold)
        }
        .fullScreenCover(isPresented: $mangaSourcePref) {
            vm.reload()
        } content: {
            SourcePreferencesView()
                .environmentObject(vm)
        }
    }
}
