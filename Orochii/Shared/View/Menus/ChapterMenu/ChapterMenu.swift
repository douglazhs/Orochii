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
            Button {
                action(.markAsRead)
            } label: {
                Label(L.Action.markAsRead, systemImage: "eye.fill")
            }
            Menu(L.Action.markPrevious) {
                Button {
                    action(.previousAsRead)
                } label: {
                    Label(L.Action.markAsRead, systemImage: "eye.fill")
                }
                Button {
                    action(.previousAsUnread)
                } label: {
                    Label(L.Action.markAsUnread, systemImage: "eye.slash.fill")
                }
            }
        }
        Section {
            Button {
                action(.download)
            } label: { 
                Label(L.Action.download, systemImage: "arrow.down")
            }
        }
    }
}
