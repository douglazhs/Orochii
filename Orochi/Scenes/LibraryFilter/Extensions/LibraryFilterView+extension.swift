//
//  LibraryFilterView+extension.swift
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
            Picker(String.Filter.filterByHeader, selection: $vm.objectFilter) {
                ForEach(ObjectFilter.allCases, id: \.self) { object in
                    Text(object.name)
                }
            }
        } header: {
            Text(String.Filter.filterByHeader)
        } footer: {
            Text(String.Filter.filterByFooter)
        }
    }
    
    /// Order elements
    /// - Returns: Order section
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            Picker(selection: $vm.filterOrder) {
                ForEach(FilterOrder.allCases, id: \.self) { order in
                    Text(order.name)
                }
            } label: { EmptyView() }
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
            Picker("", selection: $mangaInfoFilter) {
                ForEach(MangaInfoFilter.allCases, id:\.self) { filter in
                    Text(filter.name)
                }
            }
            .pickerStyle(.segmented)
            switch mangaInfoFilter {
            case .language:
                Picker("", selection: $vm.languageSelection) {
                    ForEach(Language.allCases, id: \.self) { lang in
                        Text(lang.rawValue)
                    }
                }.pickerStyle(.menu)
            case .demoPublic:
                Picker("", selection: $vm.demoPublicSelection) {
                    ForEach(DemoPublic.allCases, id: \.self) { demoPublic in
                        Text(demoPublic.name)
                    }
                }.pickerStyle(.menu)
            case .status:
                Picker("", selection: $vm.statusSelection) {
                    ForEach(MangaStatus.allCases, id: \.self) { status in
                        Text(status.config.name)
                    }
                }
                .pickerStyle(.menu)
            case .year:
                Picker("", selection: $vm.yearSelection) {
                    ForEach(Array<Int>(stride(from: 2000, through: 2022, by: 1)), id: \.hashValue) { year in
                        Text(String(year).replacingOccurrences(of: ".", with: ""))
                    }
                }
                .pickerStyle(.wheel)
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
