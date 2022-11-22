//
//  LanguagesView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct LanguagesView: View {
    @Binding var languages: [Language]
    var body: some View {
        List {
            self.languagesSection().listRowBackground(Color.clear)
        }
        .navigationTitle(String.MangaSource.languageHeader)
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(name: "aesthetic"))
    }
}

struct LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesView(languages: .constant([.enUS]))
    }
}
