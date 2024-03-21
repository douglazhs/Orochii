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
            EnumPicker("Layout", selection: $vm.pageLayout)
                .onChange(of: vm.pageLayout) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.ReaderPreferences.pageLayout.rawValue
                    )
                }
        } header: {
            Text("Page Layout")
                .foregroundStyle(Color("title"))
        } footer: {
            Text("Choose a page layout of your preference")
                .foregroundStyle(Color("secondaryText"))
        }
        .foregroundStyle(Color("bodyText"))
    }
    
    /// Manga quality
    @ViewBuilder
    func pageQualitySection() -> some View {
        Section {
            EnumPicker("Manga quality", selection: $vm.pageQuality)
                .onChange(of: vm.pageQuality) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.ReaderPreferences.pageQuality.rawValue
                    )
                }
        } header: {
            Text("Page quality")
                .foregroundStyle(Color("title"))
        } footer: {
            Text("Choose the quality of your preference")
                .foregroundStyle(Color("secondaryText"))
        }
        .foregroundStyle(Color("bodyText"))
    }
    
    /// Reading mode chooser
    @ViewBuilder
    func readingModeSection() -> some View {
        Section {
            EnumPicker("Mode", selection: $vm.readingMode)
                .onChange(of: vm.readingMode) {
                    Defaults.standard.saveInt(
                        $0.rawValue,
                        key: DefaultsKeys.ReaderPreferences.mode.rawValue
                    )
                }
        } header: {
            Text("Reading Mode")
                .foregroundStyle(Color("title"))
        } footer: {
            Text("Choose the better reading mode for you")
                .foregroundStyle(Color("secondaryText"))
        }
        .foregroundStyle(Color("bodyText"))
    }
}
