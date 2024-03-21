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
            languagesSection().listRowBackground(Color.clear)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(String.MangaSource.languageHeader)
                    .font(.title2)
                    .fontWeight(.heavy)
            }
        }
        .toolbarRole(.editor)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color("background"))
        .standardBars()
    }
}

struct LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesView(languages: .constant([.enUS]))
    }
}
