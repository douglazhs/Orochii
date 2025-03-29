//
//  ReaderPreferences.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

extension ReaderPreferencesView {
    /// Page layout chooser
    @ViewBuilder
    func pageLayoutSection() -> some View {
        Section {
            EnumPicker(L10n.readerPageSection, selection: $vm.pageLayout)
                .onChange(of: vm.pageLayout) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.ReaderPreferences.pageLayout.rawValue
                    )
                }
        } header: {
            Text(L10n.readerPageSectionHeader)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L10n.readerPageSectionFooter)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
    }
    
    /// Manga quality
    @ViewBuilder
    func pageQualitySection() -> some View {
        Section {
            EnumPicker(L10n.readerMangaSection, selection: $vm.pageQuality)
                .onChange(of: vm.pageQuality) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.ReaderPreferences.pageQuality.rawValue
                    )
                }
        } header: {
            Text(L10n.readerMangaSectionHeader)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L10n.readerMangaSectionFooter)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
    }
    
    /// Reading mode chooser
    @ViewBuilder
    func readingModeSection() -> some View {
        Section {
            EnumPicker(L10n.readerModeSection, selection: $vm.readingMode)
                .onChange(of: vm.readingMode) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.ReaderPreferences.mode.rawValue
                    )
                }
        } header: {
            Text(L10n.readerModeSectionHeader)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L10n.readerModeSectionFooter)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
    }
}
