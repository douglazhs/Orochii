//
//  ChapterView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import Kingfisher

extension ChapterView {
    @ViewBuilder
    /// Main view content
    func content() -> some View {
        ZStack(alignment: .center) {
            Color.black.edgesIgnoringSafeArea(.all)
            pagesCollection()
        }
        .onTapGesture {
            showReadBars = (showReadBars == .visible)
            ? .hidden
            : .visible
        }
    }
    
    /// Pages collection
    @ViewBuilder
    func pagesCollection() -> some View {
        TabView {
            ForEach(vm.choosenQuality(), id: \.self) { page in
                mangaPage(url: vm.api.buildURL(for: .chapterImage(
                    quality: vm.pageQuality  == .original ? .data : .dataSaver,
                    hash: vm.pages?.hash ?? "",
                    fileName: page
                )))
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
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    /// Manga actual page
    @ViewBuilder
    func mangaPage(url: URL?) -> some View {
        if let url {
            KFImage.url(url)
                .downsampling(size: CGSize(
                    width: UIScreen.width * 1.5,
                    height: UIScreen.height * 1.5
                ))
                .placeholder({ ActivityIndicator() })
                .resizable()
                .fade(duration: 0.15)
                .cacheMemoryOnly()
                .onProgress({ _, _ in
                    
                })
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
