//
//  MangaView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaView: View {
    var manga: MangaDomain
    @StateObject var vm: MangaViewModel = MangaViewModel()
    @State var showChapterReader: Bool = false
    @State var searchOffset: CGFloat = -UIScreen.width
    @State var headerOffset: CGFloat = 0
    
    init(_ manga: MangaDomain) {
        self.manga = manga
    }
    
    var body: some View {
        self.content()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(vm.showBottomBar ? .visible : .hidden, for: .bottomBar)
            .toolbar(vm.isEditingMode ? .hidden : .visible, for: .tabBar)
            .toolbarBackground(.visible, for: .bottomBar)
            .navigationBarBackButtonHidden(vm.isEditingMode)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    self.selectChaptersButton()
                }
                ToolbarItemGroup(
                    placement: vm.isEditingMode
                    ? .confirmationAction
                    : .secondaryAction
                ) {
                    self.editButton()
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    self.chapterActions()
                }
            }
            .animation(
                .easeInOut,
                value: [vm.isEditingMode, vm.showBottomBar]
            )
    }
}

struct MangaView_Previews: PreviewProvider {
    static var previews: some View {
        MangaView(MangaDomain.samples[0])
    }
}
