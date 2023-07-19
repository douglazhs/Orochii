//
//  MangaView+editablle.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import SwiftUI

extension MangaView {
    /// Select/Deselect all chapters button
    @ViewBuilder
    func selectChaptersButton() -> some View {
        if vm.isEditingMode {
            Button { vm.selectAll.toggle() } label:
            { Text(vm.selectAll ? String.Common.none : String.Common.all) }
        }
    }
    
    /// Editable view actions
    @ViewBuilder
    func editButton() ->  some View {
        if vm.isEditingMode {
            Button {
                vm.isEditingMode.toggle()
                vm.showBottomBar.toggle()
            } label: {
                Text(String.Common.done)
                    .fontWeight(.semibold)
            }
        } else {
            Menu {
                Section {
                    Button {
                        vm.isEditingMode.toggle()
                        if !vm.showBottomBar {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.275) {
                                vm.showBottomBar = true
                            }
                        } else { vm.showBottomBar = false }
                    } label: {
                        Label (
                            String.Manga.selectChapters,
                            systemImage: "checklist"
                        )
                    }
                    Button { } label: {
                        Label("View on MangaDex.co", systemImage: "safari.fill")
                    }
                } header: { Text(vm.manga.attributes?.title?.en ?? "") }
                Button(role: .destructive) {
                    
                } label: {
                    Label("Remove all Downloads", systemImage: "trash")
                }
               
            } label: { Image(systemName: "ellipsis") }
        }
    }
    
    /// Chapter actions
    @ViewBuilder
    func chapterActions() -> some View {
        Button { } label:
        { Text(String.ContextMenu.download) }
        .disabled(vm.selection.isEmpty)
        Menu {
            Section {
                Button { } label:
                { Label(String.ContextMenu.asRead, systemImage: "eye.fill") }
                Button { } label:
                { Label(String.ContextMenu.asUnread, systemImage: "eye.slash.fill") }
            } header: {
                Text("\(vm.selection.count) "
                     + String.Manga.selectedChapters.uppercased())
            }
        } label: { Text(String.Manga.mark) }
        .disabled(vm.selection.isEmpty)
    }
}
