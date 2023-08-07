//
//  MangaView+filters.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 29/11/22.
//

import SwiftUI

extension MangaView {
    /// Chapter list header
    @ViewBuilder
    func chaptersHeader() -> some View {
        Group {
            if !vm.search {
                standardBar()
            } else {
                searchBar()
            }
        }
        .disabled(vm.occurredAct)
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        )
    }
    
    /// Header chaptes bar
    @ViewBuilder
    func standardBar() -> some View {
        HStack {
            // CHAPTERS COUNT
            Text("\(vm.totalOnFeed) " +
                 String.Manga.chapHeader.uppercased())
            .lineLimit(1)
            Spacer()
            // ORDER MENU
            order()
            // SEARCH BUTTON
            searchChap()
        }
    }
    
    /// Search chapters bar
    @ViewBuilder
    func searchBar() -> some View {
        HStack(alignment: .center) {
            // TEXTFIELD BAR
            textField()
            // CANCEL BUTTON
            cancelSearch()
        }
    }
    
    /// Cancel search button
    @ViewBuilder
    func cancelSearch() -> some View {
        Button { [weak vm] in
            Haptics.shared.play(.medium)
            UIApplication.shared.endEditing()
            vm?.cancelFilter()
        } label: { Text(String.Common.cancel) }
    }
    
    /// Text field to search a specific chapter
    @ViewBuilder
    func textField() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField(text: $vm.filterQuery, axis: .horizontal) {
                Text("Chapter name or number")
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .fontWeight(.regular)
            .font(.subheadline)
            .onChange(of: vm.filterQuery) { [weak vm] _ in
                vm?.filter()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .focused($field, equals: .search)
        .frame(maxWidth: .infinity)
    }
    
    /// Search chapter button
    @ViewBuilder
    func searchChap() -> some View {
        Button { [weak vm] in
            Haptics.shared.play(.medium)
            vm?.search = true
            field = .search
            UIApplication.shared.becomeFirstResponder()
        } label: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.accentColor)
                .font(.headline)
                .fontWeight(.bold)
        }
    }
    
    /// Manga order
    @ViewBuilder
    func order() -> some View {
        Menu {
            Section {
                EnumPicker(
                    vm.feedOrder.description,
                    selection: $vm.feedOrder
                )
                .pickerStyle(.menu)
                .onChange(of: vm.feedOrder) { [weak vm] in
                    vm?.order(by: $0)
                }
            } header: { Text(String.Filter.orderByHeader.uppercased()) }
            Section {
                Button { vm.downloaded.toggle() } label: {
                    HStack {
                        Text("Downloaded")
                        Spacer()
                        if vm.downloaded {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .onChange(of: vm.downloaded) { [weak vm] in
                    vm?.filter()
                    Defaults.standard.saveBool(
                        $0,
                        key: DefaultsKeys.Chapters.downloaded.rawValue
                    )
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .foregroundColor(.accentColor)
                .font(.title3)
                .fontWeight(.bold)
        }
    }
}
