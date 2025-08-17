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
            EnumPicker(L.Reader.layout, selection: $vm.pageLayout)
                .onChange(of: vm.pageLayout) { _, newValue in
                    Defaults.standard.saveInt(
                        newValue.rawValue,
                        key: DefaultsKeys.ReaderPreferences.pageLayout.rawValue
                    )
                }
        } header: {
            Text(L.Reader.Layout.header)
        } footer: {
            Text(L.Reader.Layout.footer)
        }
    }
    
    /// Manga quality
    @ViewBuilder
    func pageQualitySection() -> some View {
        Section {
            EnumPicker(L.Reader.manga, selection: $vm.pageQuality)
                .onChange(of: vm.pageQuality) { _, newValue in
                    Defaults.standard.saveInt(
                        newValue.rawValue,
                        key: DefaultsKeys.ReaderPreferences.pageQuality.rawValue
                    )
                }
        } header: {
            Text(L.Reader.Manga.header)
        } footer: {
            Text(L.Reader.Manga.footer)
        }
    }
    
    /// Reading mode chooser
    @ViewBuilder
    func readingModeSection() -> some View {
        Section {
            EnumPicker(L.Reader.mode, selection: $vm.readingMode)
                .onChange(of: vm.readingMode) { _, newValue in
                    Defaults.standard.saveInt(
                        newValue.rawValue,
                        key: DefaultsKeys.ReaderPreferences.mode.rawValue
                    )
                }
        } header: {
            Text(L.Reader.Mode.header)
        } footer: {
            Text(L.Reader.Mode.footer)
        }
    }
}
