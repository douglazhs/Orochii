//
//  SourcePreferencesView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

extension SourcePreferencesView {
    /// MangaDex source site
    /// - Returns: MangaDex site section
    @ViewBuilder
    func siteSection() -> some View {
        Section {
            EmptyView()
        } header: {
            WebsiteStandardCell(
                header: "Source",
                title: String.Name.mangaDex,
                urlString: "https://mangadex.org",
                image: .manga_dex_icon
            )
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
            EnumPicker(String.MangaSource.mangaQuality, selection: $selectedQuality)
        } header: {
            Text(String.MangaSource.qualityHeader)
        } footer: {
            Text(String.MangaSource.qualityFooter)
        }
    }
    
    /// App Age Rating section
    @ViewBuilder
    func ageRatingSection() -> some View {
        Section {
            Toggle(isOn: $nsfw) {
                Label {
                    Text("NSFW")
                } icon: {
                    Image(systemName: "eyes.inverse")
                        .foregroundColor(.orange)
                }
            }
        } header: {
            Text(String.Adjusts.ageRatingHeader)
        } footer: {
            Text(String.Adjusts.ageRatingFooter)
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
