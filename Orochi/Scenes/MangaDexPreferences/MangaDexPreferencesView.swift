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
    @State var showActions: Bool = false
    @State var languages: [Language] = []
    var body: some View {
        NavigationStack {
            List {
                self.siteSection()
                    .listRowBackground(Color.clear)
                self.languageSection()
                    .listRowBackground(Color.accentColor.opacity(0.1))
                self.qualitySection()
                    .listRowBackground(Color.accentColor.opacity(0.1))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    self.doneButton()
                }
            }
            .navigationTitle(String.MangaSource.title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollContentBackground(.hidden)
            .background(ViewBackground(name: "aesthetic"))
        }
    }
}

struct MangaDexPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDexPreferencesView()
    }
}
