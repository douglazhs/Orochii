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
            EnumPicker(vm.objectFilter.description, selection: $vm.objectFilter).pickerStyle(.inline)
        } header: { Text(String.Filter.filterByHeader.uppercased()) }
    }
    
    /// Order elements
    /// - Returns: Order section
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            EnumPicker(String.Filter.orderByHeader, selection: $vm.filterOrder).pickerStyle(.automatic)
        } header: { Text(String.Filter.orderByHeader.uppercased()) }
    }
    
    /// Manga informations section
    /// - Returns: Manga information options to user filter
    @ViewBuilder
    func mangaInfoSection() -> some View {
        Section {
            EnumPicker("", selection: $mangaInfoFilter).pickerStyle(.menu)
            switch mangaInfoFilter {
            case .language:   EnumPicker("", selection: $vm.languageSelection)
            case .demoPublic: EnumPicker("", selection: $vm.demoPublicSelection)
            case .status:     EnumPicker("", selection: $vm.statusSelection)
            case .year:
                Picker("", selection: $vm.yearSelection) {
                    ForEach(vm.years, id: \.hashValue) { year in
                        Text(String(year).replacingOccurrences(of: ".", with: ""))
                    }
                }.pickerStyle(.menu)
            }
        } header: { Text(String.Filter.mangaInfoHeader) }
    }
}
