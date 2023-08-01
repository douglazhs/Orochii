//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

class TestViewModel: ObservableObject {
    var manga: Manga?
    var carousel: Int
    
    init(_ manga: Manga?, _ carousel: Int) {
        self.manga = manga
        self.carousel = carousel
        print("Criada VM of \(manga?.attributes?.title?.en ?? "nil") on carousel \(carousel)")
    }
    
    deinit {
        print("Deinited VM de \(manga?.attributes?.title?.en ?? "nil")")
    }
}

struct TestView: View {
    @StateObject var vm: MangaViewModel
    
    var manga: Manga
    
    init(_ manga: Manga) {
        _vm = StateObject(wrappedValue: MangaViewModel(manga: manga))
        self.manga = manga
    }
    
    var body: some View {
        Text("\(vm.tags.description)")
            .onAppear { print("Criada View de \(vm.manga.attributes?.title?.en ?? "")") }
    }
}

struct MangaView: View {
    enum Field: Int, Hashable {
        case search
    }
    
    @StateObject var vm: MangaViewModel
    @State var showAniList: Bool = false
    @State var showChapterReader: Bool = false
    @FocusState var field: Field?
    
    init(_ manga: Manga) {
        _vm = StateObject(
            wrappedValue: MangaViewModel(manga: manga)
        )
    }
    
    var body: some View {
        content()
            .onAppear { print("Criada View of \(vm.manga.attributes?.title?.en ?? "")") }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(vm.unwrapTitle(of: vm.manga))
            .toolbar(vm.showBottomBar ? .visible : .hidden, for: .bottomBar)
            .navigationBarBackButtonHidden(vm.isEditingMode)
            .toolbarBackground(.visible, for: .bottomBar)
            .navigationSplitViewColumnWidth(UIScreen.width * 0.45)
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

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
