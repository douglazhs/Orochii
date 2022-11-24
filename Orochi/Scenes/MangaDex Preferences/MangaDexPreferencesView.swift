//
//  MangaDexPreferencesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct MangaDexPreferencesView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedQuality: MangaQuality = .medium
    @State var nsfw: Bool = false
    @State var showActions: Bool = false
    @State var languages: [Language] = []
    var body: some View {
        NavigationStack {
            List {
                self.siteSection()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                self.languageSection()
                    .listRowBackground(Color.clear)
                self.qualitySection()
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
            .background(ViewBackground(with: .view_background))
        }
    }
}

struct MangaDexPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDexPreferencesView()
    }
}
