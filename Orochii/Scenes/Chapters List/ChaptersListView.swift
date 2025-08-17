//
//  ChaptersListView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/07/23.
//

import SwiftUI
import struct MangaDex.Manga
import class MangaDex.MangaMock
import class MangaDex.ChapterMock

struct ChaptersListView: View {
    @Environment(\.dismiss)
    var dismiss
    @EnvironmentObject var vm: ChapterViewModel
    
    var body: some View {
        NavigationStack {
            ScrollViewReader { reader in
                List {
                    ForEach(vm.feed) { ch in
                        ChapterStandardCell(
                            ch,
                            scanlationGroup: vm.relationship(
                                .scanlationGroup,
                                with: ch
                            ),
                            isOneshot: vm.getTag(.oneshot, of: vm.manga) != nil
                        )
                        .id(ch.id)
                        .onTapGesture {
                            if vm.current != ch {
                                vm.current = ch
                                vm.fetchChapter()
                            }
                        }
                        .overlay(alignment: .trailing) {
                            if vm.current == ch {
                                Image(systemName: "checkmark")
                                    .font(.caption2)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(Color.accentColor)
                            }
                        }
                    }
                }
                .onAppear { reader.scrollTo(vm.current.id) }
                .toolbarRole(.editor)
                .standardBars(title: L.Manga.chaptersCount(vm.feed.count), inline: true)
            }
        }
    }
}

#Preview {
    ChaptersListView()
        .environmentObject(ChapterViewModel(
            ChapterMock.chapter,
            [ChapterMock.chapter],
            MangaMock.manga)
        )
}
