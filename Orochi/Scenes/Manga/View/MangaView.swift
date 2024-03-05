//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga
import class MangaDex.MangaMock

struct MangaView: View {
    enum Field: Int, Hashable {
        case search
    }
    
    @StateObject var vm: MangaViewModel
    @State var showAniList: Bool = false
    @State var showChapterReader: Bool = false
    @FocusState var field: Field?
    @State var chSelection = Set<String?>()
    
    init(_ manga: Manga) {
        _vm = StateObject(
            wrappedValue: MangaViewModel(manga)
        )
    }
    
    var body: some View {
        content()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(vm.unwrapTitle(of: vm.manga))
            .toolbar(vm.showBottomBar ? .visible : .hidden, for: .bottomBar)
            .navigationBarBackButtonHidden(vm.isEditingMode)
            .toolbarBackground(.visible, for: .bottomBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    selectChaptersButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    editButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    chapterActions()
                }
            }
    }
}

#Preview {
    MangaView(MangaMock.manga())
}
