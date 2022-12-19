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
        ZStack {
            // STANDARD BAR WITH SOME INFORMATIONS
            self.standardBar()
                .offset(x: headerOffset)
                .frame(maxWidth: .infinity)
            // SEARCH BAR TO SEARCH A SPECIFIC CHAPTER
            self.searchBar()
                .offset(x: searchOffset)
                .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity)
    }
    
    /// Header chaptes bar
    @ViewBuilder
    func standardBar() -> some View {
        HStack {
            // CHAPTERS COUNT
            Text("\(ChapterDomain.samples.count) "
                 + String.Manga.chapHeader.uppercased())
                .foregroundColor(.primary)
                .fontWeight(.regular)
                .font(.callout)
                .lineLimit(1)
            Spacer()
            // HISTORY BUTTON
            self.historyButton()
            // ORDER MENU
            self.order()
            // SEARCH BUTTON
            self.searchChap()
        }
        .disabled(vm.occurredAct)
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
            withAnimation(.interpolatingSpring(
                mass: 2.0,
                stiffness: 5,
                damping: 5,
                initialVelocity: 0).speed(5)
            ) {
                searchOffset = -UIScreen.width
                headerOffset = 0
                vm.search = false
                UIApplication.shared.endEditing()
            }
        } label: { Text(String.Common.cancel) }
    }
    
    /// Text field to search a specific chapter
    @ViewBuilder
    func textField() -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField(text: $vm.queryFilter, axis: .horizontal) {
                Text("Search chapter")
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.secondary)
            }.ignoresSafeArea(.keyboard, edges: .bottom)
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
            withAnimation(.interpolatingSpring(
                mass: 2.0,
                stiffness: 5,
                damping: 5,
                initialVelocity: 0).speed(5)
            ) {
                searchOffset = 0
                headerOffset = UIScreen.width
                vm.search = true
                field = .search
                UIApplication.shared.becomeFirstResponder()
            }
        } label: {
            Image(systemName: "magnifyingglass")
                .font(.footnote)
                .foregroundColor(.primary)
        }.buttonStyle(.borderedProminent)
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
                    ).pickerStyle(.menu)
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
            }
        } label: {
            Image(systemName: "arrow.up.arrow.down")
                .font(.footnote)
                .foregroundColor(.primary)
        }
        .tint(.accentColor)
        .buttonStyle(.borderedProminent)
    }
}
