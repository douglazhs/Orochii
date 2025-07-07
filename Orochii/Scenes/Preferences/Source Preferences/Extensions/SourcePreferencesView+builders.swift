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
                image: Asset.Assets.mangaDexIcon.swiftUIImage
            )
        } header: {
            Text(L.MangaSource.Site.header)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L.MangaSource.Site.footer.attributedString)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
    }
    
    /// MangaDex source languages
    /// - Returns: Languages chooser section
    @ViewBuilder
    func languageSection() -> some View {
        Section {
            NavigationLink {
                LanguagesView(languages: $vm.languages)
                    .onChange(of: vm.languages) { _, newValue in
                        Defaults.standard.saveObj(
                            newValue.map { $0.rawValue },
                            key: DefaultsKeys.SrcPreferences.languages.rawValue
                        )
                        withTransaction(.init(animation: .snappy(duration: 0.5))) {
                            vm.shouldReload = true
                        }
                    }
            } label: {
                Text(
                    !vm.languages.isEmpty
                    ? vm.languages.map { $0.description }.joined(separator: ", ")
                    : L.Common.done
                )
                .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
            }
        } header: {
            Text(L.MangaSource.Language.header)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L.MangaSource.Language.footer)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
    }

    /// App Age Rating section
    @ViewBuilder
    func ageRatingSection() -> some View {
        Section {
            Toggle(isOn: $vm.nsfw) {
                Label {
                    Text(L.Common.nsfw)
                        .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
                } icon: {
                    Image(systemName: "eyes.inverse")
                        .foregroundColor(Asset.Colors.attention.swiftUIColor)
                }
            }.onChange(of: vm.nsfw) { _, newValue in
                Defaults.standard.saveBool(
                    newValue,
                    key: DefaultsKeys.SrcPreferences.nsfw.rawValue
                )
                withTransaction(.init(animation: .snappy(duration: 0.5))) {
                    vm.shouldReload = true
                }
            }
        } header: {
            Text(L.Adjusts.AgeRating.header)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L.Adjusts.AgeRating.footer.attributedString)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
    }
    
    /// MangaDex source cover quality
    @ViewBuilder
    func coverQualitySection() -> some View {
        Section {
            EnumPicker(String.Name.mangaDex, selection: $vm.mDexCoverQuality)
                .onChange(of: vm.mDexCoverQuality) { _, newValue in
                    Defaults.standard.saveInt(
                        newValue.rawValue,
                        key: DefaultsKeys.SrcPreferences.CoverQuality.mDex.rawValue
                    )
                }
                .pickerStyle(.menu)
                .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
            EnumPicker(String.Name.aniList, selection: $vm.aniLCoverQuality)
                .onChange(of: vm.aniLCoverQuality) {_, newValue in
                    Defaults.standard.saveInt(
                        newValue.rawValue,
                        key: DefaultsKeys.SrcPreferences.CoverQuality.aniL.rawValue
                    )
                }
                .pickerStyle(.menu)
                .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
        } header: {
            Text(L.MangaSource.Cover.header)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L.MangaSource.Cover.footer.attributedString)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
    }

    /// Done button
    /// - Returns: Toolbar done button
    @ViewBuilder 
    func doneButton() -> some View {
        Button { dismiss() } label: {
            Text(L.Common.done)
                .fontWeight(.semibold)
        }
    }
}
