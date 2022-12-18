//
//  ChapterView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

extension ChapterView {
    @ViewBuilder
    /// Main view content
    func content() -> some View {
        ZStack(alignment: .center) {
            Color.black.edgesIgnoringSafeArea(.all)
            self.mangaPage()
                .contextMenu {
                    Button {
                        // TODO: - Save image on gallery
                    } label: {
                        Label(
                            String.ContextMenu.savePage,
                            systemImage: "icloud.and.arrow.down.fill"
                        )
                    }
                }
        }
        .onTapGesture {
            showReadBars = (showReadBars == .visible)
            ? .hidden
            : .visible
        }
    }
    
    /// Manga actual page
    @ViewBuilder
    func mangaPage() -> some View {
        AsyncImage(url: URL(string: vm.actualChapter.pagesImages[Int(vm.actualPage)])) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
        } placeholder: {
            ActivityIndicator()
        }
    }
}
