//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

/// Focused TextField
enum Field: Int, Hashable {
    case search
}

struct MangaView: View {
    var manga: MangaDomain
    @StateObject var vm: MangaViewModel = MangaViewModel()
    @State var showAniList: Bool = false
    @State var showHistory: Bool = false
    @State var showChapterReader: Bool = false
    @State var searchOffset: CGFloat = -UIScreen.width
    @State var headerOffset: CGFloat = 0
    @FocusState var field: Field?
    
    init(_ manga: MangaDomain) {
        self.manga = manga
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
                        title: manga.title,
                        message: vm.actionMessage,
                        action: $vm.occurredAct
                    )
                }
            }
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView(MangaDomain.samples[10])
    }
}
