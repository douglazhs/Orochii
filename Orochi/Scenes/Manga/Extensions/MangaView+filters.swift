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
        // STANDARD BAR WITH SOME INFORMATIONS
        self.standardBar()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /// Header chaptes bar
    @ViewBuilder
    func standardBar() -> some View {
        HStack {
            // CHAPTERS COUNT
            Text("\(vm.chapters?.count ?? 0) "
                 + String.Manga.chapHeader.uppercased())
            .lineLimit(1)
            Spacer()
            // ORDER MENU
            order()
                .disabled(vm.occurredAct)
            // HISTORY BUTTON
            /*historyButton()
                .disabled(vm.occurredAct)
             // SEARCH BUTTON
             searchChap()
                .disabled(vm.occurredAct)*/
        }
    }
    
    /// Search chapters bar
    @ViewBuilder
    func searchBar() -> some View {
        HStack(alignment: .center) {
            // TEXTFIELD BAR
            self.textField()
            // CANCEL BUTTON
            self.cancelSearch()
        }
    }
    
    /// Cancel search button
    @ViewBuilder
    func cancelSearch() -> some View {
        Button {
            Haptics.shared.play(.medium)
            vm.search = false
            UIApplication.shared.endEditing()
        } label: { Text(String.Common.cancel) }
    }
    
    /// Text field to search a specific chapter
    @ViewBuilder
    func textField() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField(text: $vm.queryFilter, axis: .horizontal) {
                Text("Chapter name or number")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }
            .onChange(of: vm.queryFilter) { newValue in
                vm.filterChapters()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .foregroundColor(.primary)
        .padding(.horizontal, 7.5)
        .padding(.vertical, 5.5)
        .frame(maxWidth: .infinity, maxHeight: 35)
        .background(
            Color.primary.opacity(0.1),
            in: RoundedRectangle(cornerRadius: 6.5)
        )
        .focused($field, equals: .search)
    }
    
    /// Search chapter button
    @ViewBuilder
    func searchChap() -> some View {
        Button {
            Haptics.shared.play(.medium)
            vm.search = true
            field = .search
            UIApplication.shared.becomeFirstResponder()
        } label: {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.primary)
        }
        .tint(.accentColor)
    }
    
    /// Manga order
    @ViewBuilder
    func order() -> some View {
        Menu {
            Section {
                Label {
                    EnumPicker(
                        vm.chaptersOrder.description,
                        selection: $vm.chaptersOrder
                    )
                    .pickerStyle(.menu)
                    .onChange(of: vm.chaptersOrder) {
                        Defaults.standard.saveInt(
                            $0.rawValue,
                            key: DefaultsKeys.Chapters.order.rawValue
                        )
                        vm.sortChapters()
                    }
                } icon: {
                    Label(
                        vm.chaptersOrder.description,
                        systemImage: "arrow.up.arrow.down"
                    )
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
                .onChange(of: vm.downloaded) {
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
