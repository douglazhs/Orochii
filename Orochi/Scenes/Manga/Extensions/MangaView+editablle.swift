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
                withTransaction(.init(animation: .easeInOut)) {
                    vm.isEditingMode = false
                    vm.showBottomBar = false
                }
            } label: {
                Text(String.Common.done)
                    .fontWeight(.semibold)
            }
        } else {
            Menu {
                Section {
                    Button {
                        withTransaction(.init(animation: .easeInOut)) {
                            vm.isEditingMode = true
                            vm.showBottomBar = true
                        }
                    } label: {
                        Label (
                            String.Manga.selectChapters,
                            systemImage: "checklist"
                        )
                    }
                    Button {
                        UIApplication.shared
                            .safariVC(url: "\(AppURLs.MDSite.description)/manga/\(vm.manga.id)")
                    } label: {
                        Label("View on MangaDex.co", systemImage: "safari.fill")
                    }
                } header: { Text(vm.unwrapTitle(of: vm.manga)) }
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
        .disabled(vm.chSelection.isEmpty)
        Menu {
            Section {
                Button { } label:
                { Label(String.ContextMenu.asRead, systemImage: "eye.fill") }
                Button { } label:
                { Label(String.ContextMenu.asUnread, systemImage: "eye.slash.fill") }
            } header: {
                Text("\(vm.chSelection.count) "
                     + String.Manga.selectedChapters.uppercased())
            }
        } label: { Text(String.Manga.mark) }
        .disabled(vm.chSelection.isEmpty)
    }
}
