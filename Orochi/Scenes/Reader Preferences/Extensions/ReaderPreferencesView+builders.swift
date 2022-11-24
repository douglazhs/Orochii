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
        } header: {
            Text("Page Layout")
        } footer: {
            Text("Choose a page layout of your preference")
        }
    }
    
    /// Reading mode chooser
    @ViewBuilder
    func readingModeSection() -> some View {
        Section {
            EnumPicker("Mode", selection: $vm.readingMode)
        } header: {
            Text("Reading Mode")
        } footer: {
            Text("Choose the better reading mode for you")
        }
    }
}
