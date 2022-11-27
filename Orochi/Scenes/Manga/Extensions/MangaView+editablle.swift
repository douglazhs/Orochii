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
    func selectButton() -> some View {
        if isEditingMode {
            Button { selectAll.toggle() } label:
            { Text(selectAll ? String.Common.none : String.Common.all) }
        }
    }
    
    /// Editable view actions
    @ViewBuilder
    func editButton() ->  some View {
        Button { isEditingMode.toggle() } label:{
            if isEditingMode {
                Text(String.Common.done)
            } else { Label (String.Manga.selectChapters, systemImage: "checklist") }
        }
    }
    
    /// Chapter actions
    @ViewBuilder
    func chapterActions() -> some View {
        Button { } label:
        { Text(String.ContextMenu.download) }
        .disabled(selection.isEmpty)
        Menu {
            Section {
                Button { } label:
                { Label(String.ContextMenu.markAsRead, systemImage: "eye.fill") }
                Button { } label:
                { Label(String.ContextMenu.markAsUnread, systemImage: "eye.slash.fill") }
            } header: {
                Text("\(selection.count) "
                     + String.Manga.selectChapters.uppercased())
            }
        } label: { Text(String.Manga.mark) }
        .disabled(selection.isEmpty)
    }
}
