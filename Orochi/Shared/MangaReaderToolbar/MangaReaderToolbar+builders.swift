//
//  MangaReaderToolbar+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

extension ReaderToolbar {
    /// Chapters list
    @ViewBuilder
    func chaptersMenu() -> some View {
        List {
            Section {
                Picker(selection: $vm.actualChapter) {
                    ForEach(ChapterDomain.samples, id: \.self) { chapter in
                        ChapterListStandardCell(chapter)
                    }
                } label: {
                    Text(manga.title).font(.subheadline)
                        .foregroundColor(.primary)
                        .fontWeight(.regular)
                }
                .pickerStyle(.inline)
                .onChange(of: vm.actualChapter) { _ in
                    vm.loadChapter()
                }
            } header: {
                Text("CHAPTERS OF:")
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(with: .view_background))
    }
    
    /// Principal toolbar item
    @ViewBuilder
    func principalItem() -> some View {
        VStack {
            Text(vm.actualChapter.title)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Text("**\(vm.actualChapter.volume)**")
                .foregroundColor(Color(uiColor: .systemGray))
                .font(.caption2)
        }
    }
    
    /// Manga page slider
    @ViewBuilder
    func pageSlider() -> some View {
        VStack(spacing: 2.5) {
            UISliderView(
                value: $vm.actualPage,
                minValue: 0,
                maxValue: Double(vm.actualChapter.pagesImages.count - 1)
            )
            Text("\(String(format: "%.0f", vm.actualPage + 1)) **OF** \(vm.actualChapter.pagesImages.count)")
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
}
