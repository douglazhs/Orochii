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
            .toolbarRole(.editor)
            .toolbar(vm.showBottomBar ? .visible : .hidden, for: .bottomBar)
            .navigationBarBackButtonHidden(vm.isEditingMode)
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
                ToolbarItem(placement: .principal) {
                    Text(vm.unwrapTitle(of: vm.manga))
                        .font(.headline)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.heavy)
                }
            }
    }
}

#Preview {
    MangaView(MangaMock.manga)
}
