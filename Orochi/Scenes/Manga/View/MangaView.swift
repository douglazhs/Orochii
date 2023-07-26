//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

/// Focused TextField
enum Field: Int, Hashable {
    case search
}

struct MangaView: View {
    @StateObject var vm: MangaViewModel
    @State var showAniList: Bool = false
    @State var showHistory: Bool = false
    @State var showChapterReader: Bool = false
    @State var isTruncated: Bool = false
    @State var descSize: CGSize = .zero
    @FocusState var field: Field?
    
    init(_ manga: Manga) {
        _vm = StateObject(wrappedValue: MangaViewModel(manga: manga))
    }
    
    var body: some View {
        content()
            .navigationBarTitleDisplayMode(.inline)
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
                    ActionPopUp(
                        title: vm.unwrapTitle(of: vm.manga),
                        message: vm.actionMessage,
                        action: $vm.occurredAct
                    )
                }
            }
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        /*MangaView()*/
    }
}
