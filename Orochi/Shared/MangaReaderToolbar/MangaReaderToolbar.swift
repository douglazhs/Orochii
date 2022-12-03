//
//  MangaReaderToolbar.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

struct ReaderToolbar: ViewModifier {
    @EnvironmentObject var vm: ChapterViewModel
    var manga: MangaDomain
    @Binding var showChaptersList: Bool
    @Binding var showReaderPreferences: Bool
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { showChaptersList = true } label:
                    { Image(systemName: "list.triangle") }
                    .popover(isPresented: $showChaptersList) {
                        switch UIDevice.current.userInterfaceIdiom {
                        case .pad:
                            self.chaptersMenu()
                                .frame(
                                    width:  UIScreen.width  * 0.5,
                                    height: UIScreen.height * 0.5
                                )
                        default:
                            self.chaptersMenu()
                                .presentationDetents([.medium, .fraction(0.75)])
                                .presentationDragIndicator(.visible)
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { showReaderPreferences = true } label:
                    { Image(systemName: "book") }
                    .sheet(isPresented: $showReaderPreferences) {
                        ReaderPreferencesView()
                            .environmentObject(vm)
                            .presentationDragIndicator(.visible)
                    }
                }
                ToolbarItem(placement: .principal) { self.principalItem() }
                ToolbarItem(placement: .bottomBar) { self.pageSlider() }
            }
    }
}
