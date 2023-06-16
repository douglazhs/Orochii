//
//  ChapterMenu.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 26/11/22.
//

import SwiftUI

enum ChapterMenuActions {
    case download, markAsRead, previousAsRead, previousAsUnread
}

struct ChapterMenu: View {
    var action: (ChapterMenuActions) -> Void
    
    var body: some View {
        Section {
            Button {action(.markAsRead) } label:
            { Label(String.ContextMenu.markAsRead, systemImage: "eye.fill") }
            Menu(String.ContextMenu.markPrevious) {
                Button { action(.previousAsRead) } label:
                { Label(String.ContextMenu.markAsRead, systemImage: "eye.fill") }
                Button { action(.previousAsUnread) } label:
                { Label(String.ContextMenu.markAsUnread, systemImage: "eye.slash.fill") }
            }
        }
        Section {
            Button { action(.download)} label:
            { Label(String.ContextMenu.download, systemImage: "arrow.down") }
        }
    }
}
