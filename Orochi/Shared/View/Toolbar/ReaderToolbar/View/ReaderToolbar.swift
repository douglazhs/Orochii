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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { showChaptersList = true } label:
                    { Image(systemName: "list.triangle") }
                    .popover(isPresented: $showChaptersList) {
                        switch Constants.device {
                        case .pad:
                            self.chaptersMenu()
                                .frame(
                                    width:  UIScreen.width  * 0.5,
                                    height: UIScreen.height * 0.5
                                )
                        default:
                            self.chaptersMenu()
                                .presentationDetents([.medium, .large])
                                .presentationDragIndicator(.visible)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) { self.readerPreferences() }
                ToolbarItem(placement: .principal) { self.principalItem() }
                ToolbarItem(placement: .bottomBar) { self.pageSlider() }
            }
    }
}
