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
    // - MARK: 
    @ViewBuilder
    func siteSection() -> some View {
        Section {
            WebsiteStandardCell(
                title: "mangadex.org",
                urlString: AppURLs.MDSite.description,
                image: .manga_dex_icon
            )
        } footer: {
            Text(String.MangaSource.siteFooter)
                .foregroundStyle(Color("secondaryText"))
        }
    }
    
    /// MangaDex source languages
    /// - Returns: Languages chooser section
    @ViewBuilder
    func languageSection() -> some View {
        Section {
            NavigationLink {
                LanguagesView(languages: $vm.languages)
                    .onChange(of: vm.languages) {
                        Defaults.standard.saveObj(
                            $0.map { $0.rawValue },
                            key: DefaultsKeys.SrcPreferences.languages.rawValue
                        )
                        withTransaction(.init(animation: .easeInOut(duration: 0.25))) {
                            vm.shouldReload = true
                        }
                    }
            } label: {
                Text(String.MangaSource.languageHeader)
                    .foregroundStyle(Color("bodyText"))
            }
        } header: {
            Text(String.MangaSource.languageHeader)
                .foregroundStyle(Color("title"))
        } footer: {
            Text(String.MangaSource.languageFooter)
                .foregroundStyle(Color("secondaryText"))
        }
    }
    
    /// App Age Rating section
    @ViewBuilder
    func ageRatingSection() -> some View {
        Section {
            Toggle(isOn: $vm.nsfw) {
                Label {
                    Text("NSFW")
                        .foregroundStyle(Color("bodyText"))
                } icon: {
                    Image(systemName: "eyes.inverse")
                        .foregroundColor(Color("attention"))
                }
            }.onChange(of: vm.nsfw) {
                Defaults.standard.saveBool(
                    $0,
                    key: DefaultsKeys.SrcPreferences.nsfw.rawValue
                )
                vm.shouldReload = true
            }
        } header: {
            Text(String.Adjusts.ageRatingHeader)
                .foregroundStyle(Color("title"))
        } footer: {
            Text(String.Adjusts.ageRatingFooter)
                .foregroundStyle(Color("secondaryText"))
        }
    }
    
    /// Done button
    /// - Returns: Toolbar done button
    @ViewBuilder func doneButton() -> some View {
        Button { dismiss() } label: {
            Text(String.Common.done)
                .fontWeight(.semibold)
        }
    }
}
