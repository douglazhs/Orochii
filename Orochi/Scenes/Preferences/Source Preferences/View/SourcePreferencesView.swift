//
//  SourcePreferencesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct SourcePreferencesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: DiscoverViewModel
    
    var body: some View {
        NavigationStack {
            List {
                self.siteSection()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                self.languageSection()
                    .listRowBackground(Color.clear)
                self.ageRatingSection()
                    .listRowBackground(Color.clear)
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    self.doneButton()
                }
            }
            .listStyle(.grouped)
            .navigationTitle(String.MangaSource.title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(BlurBackground(with: .view_background))
        }
    }
}

#Preview {
    SourcePreferencesView()
        .environmentObject(DiscoverViewModel())
}
