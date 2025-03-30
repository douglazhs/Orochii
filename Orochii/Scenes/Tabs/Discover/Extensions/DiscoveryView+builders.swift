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
            SearchStyleView($viewStyle)
                .environmentObject(vm)
        case .initial:
            InitialStyleView($viewStyle)
                .environmentObject(vm)
        }
    }
    
    /// Search history from user
    @ViewBuilder
    func searchSuggestions() -> some View {
        if vm.nameQuery.isEmpty && !vm.suggestions.isEmpty {
            Group {
                ForEach(vm.suggestions.indices, id: \.self) { index in
                    Button {
                        vm.fillWithHistory(on: index)
                    } label: {
                        Text(vm.suggestions[index])
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            vm.removeQuery(on: index)
                        } label: {
                            Text(L.Common.remove)
                        }
                    }
                }
            }.listSectionSeparator(.hidden)
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
