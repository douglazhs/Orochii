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
    @ViewBuilder func content() -> some View {
        switch viewStyle {
        case .search:  SearchStyleView(mangas: MangaDomain.samples, $viewStyle)
        case .initial: InitialStyleView().environmentObject(vm)
        }
    }
    
    /// Manga source preferences
    /// - Returns: Manga source preferences button
    @ViewBuilder
    func mangaSourceButton() -> some View {
        Button { mangaSourcePref = true } label: {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .foregroundColor(.accentColor)
        }
        .sheet(isPresented: $mangaSourcePref) {
            SourcePreferencesView()
        }
    }
}
