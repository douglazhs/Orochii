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
            WebsiteStandardCell(
                title: String.Name.mangaDex,
                urlString: AppURLs.MDSite.description,
                image: .manga_dex_icon
            )
        } header: {
            Text(String.MangaSource.title)
        } footer: {
            Text(String.MangaSource.siteFooter)
        }
    }
    
    /// MangaDex source languages
    /// - Returns: Languages chooser section
    @ViewBuilder
    func languageSection() -> some View {
        Section {
            NavigationLink(destination: LanguagesView(languages: $vm.languages)) {
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
            EnumPicker(String.MangaSource.mangaQuality, selection: $vm.selectedQuality)
                .onChange(of: vm.selectedQuality) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.SrcPreferences.quality.rawValue
                    )
                }
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
            Toggle(isOn: $vm.nsfw) {
                Label {
                    Text("NSFW")
                } icon: {
                    Image(systemName: "eyes.inverse")
                        .foregroundColor(.orange)
                }
            }.onChange(of: vm.nsfw) {
                Defaults.standard.saveBool(
                    $0,
                    key: DefaultsKeys.SrcPreferences.nsfw.rawValue
                )
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
