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
        List(Language.allCases, id: \.self) { lang in
            Button {
                if !languages.contains(lang) {
                    languages.append(lang)
                } else { languages.removeAll(where: { $0 == lang }) }
            } label: {
                HStack {
                    Text(lang.rawValue)
                    Spacer()
                    if languages.contains(lang) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.accentColor)
                    } else { EmptyView() }
                }
            }
            .foregroundColor(.primary)
            .listRowBackground(Color.clear)
        }
        .navigationTitle(String.MangaSource.languageHeader)
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(name: "aesthetic"))
    }
}

struct LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesView(languages: .constant([.enUS]))
    }
}
