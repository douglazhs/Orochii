//
//  ReaderToolbar+builders.swift
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
                    HStack {
                        Text("\(ChapterDomain.samples.count) CHAPTERS")
                            .font(.subheadline)
                            .foregroundColor(.primary)
                            .fontWeight(.regular)
                        Spacer()
                    }
                }
                .pickerStyle(.inline)
                .tint(.indigo)
                .onChange(of: vm.actualChapter) { _ in
                    vm.loadChapter()
                }
            } header: {
                HStack {
                    Spacer()
                    Text("**UPDATED**: \(manga.lastUpdated)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(BlurBackground(with: .view_background))
    }
    
    /// Principal toolbar item
    @ViewBuilder
    func principalItem() -> some View {
        VStack {
            Text(vm.actualChapter.title)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Text("**\(vm.actualChapter.volume)**")
                .foregroundColor(Color(uiColor: .systemGray))
                .font(.caption2)
        }
    }
    
    /// Reader preferences trailing button
    @ViewBuilder
    func readerPreferences() -> some View {
        Button {
            showReaderPreferences = true
        } label: {
            Image(systemName: "book")
        }
        .sheet(isPresented: $showReaderPreferences) {
            ReaderPreferencesView()
                .environmentObject(vm)
                .presentationDetents([.medium, .large])
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
            Text("\(String(format: "%.0f", vm.actualPage + 1)) "
                 + "\(String.Common.of.uppercased()) "
                 + "\(vm.actualChapter.pagesImages.count)")
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
}
