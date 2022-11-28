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
        Button {
            vm.isEditingMode.toggle()
            if !vm.showBottomBar {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.275) {
                    vm.showBottomBar = true
                }
            } else { vm.showBottomBar = false }
        } label:{
            if vm.isEditingMode {
                Text(String.Common.done)
            } else { Label (String.Manga.selectChapters, systemImage: "checklist") }
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
                { Label(String.ContextMenu.markAsRead, systemImage: "eye.fill") }
                Button { } label:
                { Label(String.ContextMenu.markAsUnread, systemImage: "eye.slash.fill") }
            } header: {
                Text("\(vm.selection.count) "
                     + String.Manga.selectChapters.uppercased())
            }
        } label: { Text(String.Manga.mark) }
        .disabled(vm.selection.isEmpty)
    }
}
