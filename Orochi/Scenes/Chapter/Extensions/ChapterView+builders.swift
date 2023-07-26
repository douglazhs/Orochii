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
            Color.black
            pagesCollection()
        }
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            showReadBars = (showReadBars == .visible)
            ? .hidden
            : .visible
        }
    }
    
    /// Pages collection according to user reading mode preference
    @ViewBuilder
    func pagesCollection() -> some View {
        switch vm.readingMode {
        case .webtoon: webtoonMode()
        case .defaultMode:
            switch vm.format {
            case .normal: horizontalMode()
            case .webtoon: webtoonMode()
            }
        default: horizontalMode()
        }
    }
    
    /// Horizontal reading mode
    @ViewBuilder
    func horizontalMode() -> some View {
        TabView {
            ForEach(
                (vm.readingMode == .leftToRight || vm.format == .normal)
                ? vm.choosenQuality()
                : vm.choosenQuality().reversed(),
                id: \.self
            ) { page in
                ZStack {
                    Color.black.edgesIgnoringSafeArea(.all)
                    ChapterPageView(
                        url: vm.api.buildURL(for: .chapterImage(
                            quality: vm.pageQuality  == .original ? .data : .dataSaver,
                            hash: vm.pages?.hash ?? "",
                            fileName: page
                        )),
                        cacheKey: page
                    )
                    .contextMenu {
                        Button { vm.savePage(page) } label: {
                            Label(
                                String.ContextMenu.savePage,
                                systemImage: "icloud.and.arrow.down.fill"
                            )
                        }
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    
    /// Scrollable reading mode
    @ViewBuilder
    func webtoonMode() -> some View {
        ScrollViewReader { _ in
            ScrollView(showsIndicators: false) {
                VStack(spacing: .zero) {
                    ForEach(vm.choosenQuality(), id: \.self) { page in
                        ChapterPageView(
                            url: vm.api.buildURL(for: .chapterImage(
                                quality: vm.pageQuality  == .original ? .data : .dataSaver,
                                hash: vm.pages?.hash ?? "",
                                fileName: page
                            )),
                            cacheKey: page
                        )
                        .id(page)
                        .contextMenu {
                            Button {
                                let imageSaver = ImageSaver()
                                imageSaver.writeToPhotoAlbum(page)
                            } label: {
                                Label(
                                    String.ContextMenu.savePage,
                                    systemImage: "icloud.and.arrow.down.fill"
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}
