//
//  ReaderToolbar.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import struct MangaDex.Manga

struct ReaderToolbar: ViewModifier {
    @EnvironmentObject var vm: ChapterViewModel
    @Binding var showChaptersList: Bool
    @Binding var showReaderPreferences: Bool
    
    func body(content: Content) -> some View {
        content
            .standardBars(title: vm.mountChapterTitle())
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { showChaptersList = true } label: {
                        Image(systemName: "list.triangle")
                    }
                    .fullScreenCover(isPresented: $showChaptersList) {
                        ChaptersListView().environmentObject(vm)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) { readerPreferences() }
                ToolbarItem(placement: .bottomBar) { pageSlider() }
            }
            .onAppear {
                let thumbImage = UIImage(systemName: "circle.fill")
                UISlider.appearance().setThumbImage(
                    thumbImage,
                    for: .normal
                )
                UISlider.appearance().setThumbImage(
                    thumbImage,
                    for: .highlighted
                )
            }
    }
}
