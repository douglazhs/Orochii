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
        chaptersBar()
            .disabled(vm.occurredAct)
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
    }
    
    /// Header chaptes bar
    @ViewBuilder
    func chaptersBar() -> some View {
        HStack {
            // CHAPTERS COUNT
            Text(L.Manga.chaptersCount(vm.totalOnFeed).uppercased())
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
                .font(.footnote)
                .fontWeight(.regular)
            Spacer()
            // ORDER MENU
            order()
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
                    vm?.orderFeed(by: $0)
                }
            } header: {
                Text(L.OrderBy.header)
            }
            Section {
                Button { vm.downloaded.toggle() } label: {
                    HStack {
                        Text(L.Filter.downloaded)
                        Spacer()
                        if vm.downloaded {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                        }
                    }
                }
                .onChange(of: vm.downloaded) { [weak vm] in
                    vm?.filterFeed()
                    Defaults.standard.saveBool(
                        $0,
                        key: DefaultsKeys.Chapters.downloaded.rawValue
                    )
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .foregroundStyle(Asset.Colors.button.swiftUIColor)
        }
    }
}
