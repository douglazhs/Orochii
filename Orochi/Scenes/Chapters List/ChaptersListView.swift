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
                                "scanlation_group",
                                with: ch
                            ),
                            isOneshot: vm.getTag("Oneshot", of: vm.manga) != nil
                        )
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.visible, edges: .bottom)
                        .listSectionSeparator(.hidden)
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
                                    .foregroundColor(Color.ORCH.button)
                            }
                        }
                    }
                }
                .onAppear { reader.scrollTo(vm.current.id) }
                .toolbarRole(.editor)
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.ORCH.background)
                .standardBars()
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("\(vm.feed.count) chapter(s)")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                }
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
