//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaView: View {
    var manga: MangaDomain
    @State var chapterReader: Bool = false
    @StateObject var vm: MangaViewModel = MangaViewModel()
    @State var selection = Set<UUID>()
    @State var isEditingMode: Bool = false
    @State var selectAll: Bool = false
    
    init(_ manga: MangaDomain) {
        self.manga = manga
    }
    
    var body: some View {
        self.content()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(isEditingMode ? .visible : .hidden, for: .bottomBar)
            .toolbar(isEditingMode ? .hidden : .visible, for: .tabBar)
            .toolbarBackground(.visible, for: .bottomBar)
            .navigationBarBackButtonHidden(isEditingMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    self.selectButton()
                }
                ToolbarItemGroup(placement: isEditingMode ? .confirmationAction : .secondaryAction) {
                    self.editButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
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
            }.animation(
                .easeInOut(duration: 0.01),
                value: [isEditingMode, vm.ascending]
            )
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView(MangaDomain.samples[0])
    }
}
