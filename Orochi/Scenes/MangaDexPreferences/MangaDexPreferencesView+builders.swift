//
//  MangaDexPreferencesView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

extension MangaDexPreferencesView {
    /// MangaDex source site
    /// - Returns: MangaDex site section
    @ViewBuilder
    func siteSection() -> some View {
        Section {
            HStack(alignment: .top, spacing: 5) {
                Image("mangaDex_icon")
                    .resizable()
                    .frame(
                        maxWidth: UIScreen.width/10,
                        maxHeight: UIScreen.width/10
                    )
                    .cornerRadius(5.5)
                VStack(alignment: .leading) {
                    Text("MangaDex")
                    Link("Website", destination: URL(string: "https://mangadex.org")!)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
                Spacer()
                EmptyView()
            }
            .padding()
            .background(StandardCellGradient())
        } footer: { Text(String.MangaSource.siteFooter) }
    }
    
    /// MangaDex source languages
    /// - Returns: Languages chooser section
    @ViewBuilder
    func languageSection() -> some View {
        Section {
            NavigationLink(destination: LanguagesView(languages: $languages)) {
                Text(String.MangaSource.languageHeader)
            }
        } header: {
            Text(String.MangaSource.languageHeader)
        } footer: { Text(String.MangaSource.languageFooter) }
    }
    
    /// MangaDex quality of mangas
    /// - Returns: Manga's quality chooser
    @ViewBuilder
    func qualitySection() -> some View {
        Section {
            Picker("Manga Quality", selection: $selectedQuality) {
                ForEach(MangaQuality.allCases, id: \.self) { quality in
                    Text(quality.name)
                }
            }.tint(.primary)
        } header: {
            Text(String.MangaSource.qualityHeader)
        } footer: {
            Text(String.MangaSource.qualityFooter)
        }
    }
    
    /// Done button
    /// - Returns: Toolbar done button
    @ViewBuilder func doneButton() -> some View {
        Button { dismiss() } label: {
            Text(String.Common.done)
        }
    }
}
