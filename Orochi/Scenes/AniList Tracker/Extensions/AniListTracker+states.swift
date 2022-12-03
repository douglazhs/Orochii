//
//  AniListTracker+states.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension AniListTracker {
    /// Manga states section
    @ViewBuilder
    func statesSection() -> some View {
        HStack(alignment: .center) {
            // CHAPTER CHOOSER
            self.mangaChapters()
            Spacer()
            // VOLUME CHOOSER
            self.mangaVol()
        }
    }
    
    /// Manga chapters picker
    @ViewBuilder
    func mangaChapters() -> some View {
        let chaptersNumber = Array(stride(
            from: 0,
            through: 1000.0,
            by: 1.0)
        )
        Section {
            Button { vm.showChapterPicker = true } label: {
                Text("\(String(format: "%.0f", vm.chapter)) | -")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }.buttonStyle(.bordered)
            .tint(.secondary)
        } header: { Text("CH.").font(.footnote) }
        .sheet(isPresented: $vm.showChapterPicker) {
            NumberPicker(
                title: "Chapter",
                values: chaptersNumber,
                selection: $vm.chapter,
                cover: manga.cover,
                format: "%.0f"
            )
            .presentationDetents([.height(vm.sheetHeight)])
        }
    }
    
    /// Manga volume picker
    @ViewBuilder
    func mangaVol() -> some View {
        let volumesNumber = Array(stride(
            from: 0,
            through: 1000.0,
            by: 1.0)
        )
        Section {
            Button { vm.showVolumePicker = true } label: {
                Text("\(String(format: "%.0f", vm.volume)) | -")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }.buttonStyle(.bordered)
            .tint(.secondary)
        } header: { Text("VOL.").font(.footnote) }
        .sheet(isPresented: $vm.showVolumePicker) {
            NumberPicker(
                title: "Volume",
                values: volumesNumber,
                selection: $vm.volume,
                cover: manga.cover,
                format: "%.0f"
            )
            .presentationDetents([.height(vm.sheetHeight)])
        }
    }
    
    /// Manga score section
    @ViewBuilder
    func scoreSection() -> some View {
        let scoreNumbers = Array(stride(
            from: 0,
            through: 10.0,
            by: 1.0)
        )
        Section {
            Button { vm.showScorePicker = true } label: {
                Text("\(String(format: "%.1f", vm.score)) | 10.0")
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
            }.buttonStyle(.bordered)
            .tint(.secondary)
        } header: { Text("SCORE").font(.footnote) }
        .sheet(isPresented: $vm.showScorePicker) {
            NumberPicker(
                title: "Score",
                values: scoreNumbers,
                selection: $vm.score,
                cover: manga.cover,
                format: "%.1f"
            )
            .presentationDetents([.height(vm.sheetHeight)])
        }
    }
}
