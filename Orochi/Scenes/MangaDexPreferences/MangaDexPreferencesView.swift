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
        NavigationView {
            List {
                self.siteSection()
                self.languageSection()
                self.qualitySection()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    self.doneButton()
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("MangaDex Source")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MangaDexPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        MangaDexPreferencesView()
    }
}
