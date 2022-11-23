//
//  LibraryFilterView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension LibraryFilterView {
    /// Objects to filter results
    /// - Returns: Objects filters
    @ViewBuilder
    func objectFilterSection() -> some View {
        Section {
            EnumPicker(String.Filter.filterByHeader, selection: $vm.objectFilter)
        } footer: {
            Text(String.Filter.filterByFooter)
        }
    }
    
    /// Order elements
    /// - Returns: Order section
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            EnumPicker("", selection: $vm.filterOrder).pickerStyle(.inline)
            .pickerStyle(.inline)
        } header: {
            Text(String.Filter.orderByHeader)
        } footer: {
            Text(String.Filter.orderByFooter)
        }
    }
    
    /// Manga informations section
    /// - Returns: Manga information options to user filter
    @ViewBuilder
    func mangaInfoSection() -> some View {
        Section {
            EnumPicker("", selection: $mangaInfoFilter).pickerStyle(.segmented)
            switch mangaInfoFilter {
            case .language:   EnumPicker("", selection: $vm.languageSelection)
            case .demoPublic: EnumPicker("", selection: $vm.demoPublicSelection)
            case .status:     EnumPicker("", selection: $vm.statusSelection)
            case .year:
                Picker("", selection: $vm.yearSelection) {
                    ForEach(vm.years, id: \.hashValue) { year in
                        Text(String(year).replacingOccurrences(of: ".", with: ""))
                    }
                }.pickerStyle(.wheel)
            }
        } header: { Text(String.Filter.mangaInfoHeader) }
    }
    
    /// Done button
    /// - Returns: Toolbar done button
    @ViewBuilder
    func doneButton() -> some View {
        Button { dismiss() } label: {
            Text(String.Common.done)
        }
    }
    
    /// Cancel button
    /// - Returns: Toolbar cancel button
    @ViewBuilder
    func cancelButton() -> some View {
        Button { dismiss() } label: {
            Text(String.Common.cancel)
        }
        .tint(.primary)
    }
}
