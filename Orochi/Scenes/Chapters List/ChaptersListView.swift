//
//  ChaptersListView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/07/23.
//

import SwiftUI
import struct MangaDex.Chapter

struct ChaptersListView: View {
    @Environment(\.dismiss) var dismiss
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
                             )
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
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
                .onAppear { reader.scrollTo(vm.current.id) }
                .listStyle(.plain)
                .scrollContentBackground(.visible)
                .navigationTitle("\(vm.feed.count) Chapters")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.footnote)
                                .fontWeight(.heavy)
                        }
                        .tint(.white)
                    }
                }
            }
        }
    }
}

struct ChaptersListView_Previews: PreviewProvider {
    static var previews: some View {
        ChaptersListView()
    }
}
