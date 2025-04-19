//
//  SourcePreferencesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct SourcePreferencesView: View {
    @Environment(\.dismiss) 
    var dismiss
    @EnvironmentObject var vm: DiscoverViewModel
    
    var body: some View {
        NavigationStack {
            List {
                siteSection()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                languageSection()
                    .listRowBackground(Color.clear)
                ageRatingSection()
                    .listRowBackground(Color.clear)
                coverQualitySection()
                    .listRowBackground(Color.clear)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    doneButton()
                }
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(Asset.Colors.background.swiftUIColor)
            .standardBars(title: L.MangaSource.title)
        }
    }
}

#Preview {
    SourcePreferencesView()
        .environmentObject(DiscoverViewModel())
}
