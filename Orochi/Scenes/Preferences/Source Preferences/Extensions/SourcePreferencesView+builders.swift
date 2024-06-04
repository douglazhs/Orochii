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
                urlString: AppURLs.mdSite.description,
                image: .mangaDexIcon
            )
        } header: {
            Text("Main Orochii Source")
                .foregroundStyle(Color.ORCH.secondaryTitle)
        } footer: {
            Text(String.MangaSource.siteFooter)
                .foregroundStyle(Color.ORCH.secondaryText)
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
                Text(vm.languages.map { $0.description }.joined(separator: ", ") )
                    .foregroundStyle(Color.ORCH.primaryText)
            }
        } header: {
            Text(String.MangaSource.languageHeader)
                .foregroundStyle(Color.ORCH.secondaryTitle)
        } footer: {
            Text(String.MangaSource.languageFooter)
                .foregroundStyle(Color.ORCH.secondaryText)
        }
    }

    /// App Age Rating section
    @ViewBuilder
    func ageRatingSection() -> some View {
        Section {
            Toggle(isOn: $vm.nsfw) {
                Label {
                    Text("NSFW")
                        .foregroundStyle(Color.ORCH.primaryText)
                } icon: {
                    Image(systemName: "eyes.inverse")
                        .foregroundColor(Color.ORCH.attention)
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
                .foregroundStyle(Color.ORCH.secondaryTitle)
        } footer: {
            Text(String.Adjusts.ageRatingFooter)
                .foregroundStyle(Color.ORCH.secondaryText)
        }
    }
    
    /// MangaDex source cover quality
    @ViewBuilder
    func coverQualitySection() -> some View {
        Section {
            EnumPicker("Variant", selection: $vm.coverQuality)
                .onChange(of: vm.coverQuality) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.SrcPreferences.coverQuality.rawValue
                    )
                    vm.shouldReload = true
                }
                .foregroundStyle(Color.ORCH.primaryText)
        } header: {
            Text("Cover Quality")
                .foregroundStyle(Color.ORCH.secondaryTitle)
        } footer: {
            Text("MangaDex source cover quality")
                .foregroundStyle(Color.ORCH.secondaryText)
        }
    }

    /// Done button
    /// - Returns: Toolbar done button
    @ViewBuilder 
    func doneButton() -> some View {
        Button { dismiss() } label: {
            Text(String.Common.done)
                .fontWeight(.semibold)
        }
    }
}
