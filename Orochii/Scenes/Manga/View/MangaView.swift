//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga
import class MangaDex.MangaMock
import struct MangaDex.Cover

struct MangaView: View {
    enum Field: Int, Hashable {
        case search
    }
    
    @StateObject var vm: MangaViewModel
    @State var showAniList: Bool = false
    @State var showChapterReader: Bool = false
    @State var showFullName: Bool = false
    @State var showCover: Bool = false
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
            .fullScreenCover(item: $vm.selectedChapter) {
                ChapterView(
                    $0,
                    vm.chapters,
                    of: vm.manga
                )
            }
            .sheet(isPresented: $showCover) {
                CoverList()
                    .environmentObject(vm)
                    .interactiveDismissDisabled()
                    .presentationContentInteraction(.resizes)
                    .presentationBackgroundInteraction(.disabled)
                    .presentationCornerRadius(.zero)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    selectChaptersButton()
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    editButton()
                    ShareLink(
                        item: "\(AppURLs.mdSite.description)/manga/\(vm.manga.id)",
                        subject: Text("\(vm.unwrapTitle(of: vm.manga))"),
                        message: Text(L.Manga.Action.Share.message(vm.unwrapTitle(of: vm.manga)))
                    )
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    chapterActions()
                }
            }
    }
}

#Preview {
    MangaView(MangaMock.manga)
}
