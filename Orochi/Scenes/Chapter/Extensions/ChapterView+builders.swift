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
            if vm.error == nil {
                pagesCollection()
            } else {
                Text(vm.error?.localizedDescription ?? "error")
                    .font(.footnote)
                    .fontWeight(.medium)
            }
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
        TabView(selection: $vm.actualPage) {
            ForEach(vm.pages.indices, id: \.self) { index in
                ChapterPageView(
                    url: vm.api.buildURL(for: .chapterImage(
                        quality: vm.pageQuality  == .original ? .data : .dataSaver,
                        hash: vm.content?.hash ?? "",
                        fileName: vm.pages[index]
                    )),
                    cacheKey: vm.pages[index]
                )
                .tag(Double(index))
                .contextMenu {
                    Button { vm.savePage(of: index) } label: {
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
    
    /// Scrollable reading mode
    @ViewBuilder
    func webtoonMode() -> some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack(spacing: .zero) {
                    ForEach(vm.pages.indices, id: \.self) { index in
                        ChapterPageView(
                            url: vm.api.buildURL(for: .chapterImage(
                                quality: vm.pageQuality  == .original ? .data : .dataSaver,
                                hash: vm.content?.hash ?? "",
                                fileName: vm.pages[index]
                            )),
                            cacheKey: vm.pages[index]
                        )
                        .id(Int(index))
                        .contextMenu {
                            Button {
                                vm.savePage(of: index)
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
            /*.onChange(of: vm.actualPage) { index in
                withAnimation(.easeInOut(duration: 0.125)) {
                    proxy.scrollTo(Int(index))
                }
            }*/
        }
    }
}
