//
//  AniListTracker+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI

extension AniListTracker {
    /// Manga information
    @ViewBuilder
    func mangaInfo() -> some View {
        HStack(alignment: .top) {
            // MANGA COVER
            Image(manga.cover)
                .resizable()
                .cornerRadius(2.5)
                .frame(width: 65, height: 90)
            VStack(alignment: .leading) {
                HStack {
                    // MANGA TITLE
                    Text(manga.title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Spacer()
                    // MANGA YEAR
                    Text(manga.year)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                // MANGA AUTHOR
                Text(manga.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
        }.frame(maxHeight: 90)
    }
    
    /// Update anilist button
    @ViewBuilder
    func actionsButtons() -> some View {
        HStack {
            Button {
                // TODO: - Cancel changes
                dismiss()
            } label: {
                HStack {
                    Text("Cancel")
                }
            }
            Spacer()
            Button {
                // TODO: - Save changes
                withAnimation(.easeInOut(duration: 0.175)) {
                    action.wrappedValue = true
                }
                Haptics.shared.notify(.success)
                dismiss()
            } label: {
                HStack {
                    Text("Update")
                        .fontWeight(.semibold)
                }
            }
        }
        .tint(.indigo)
        .buttonStyle(.borderless)
    }
    
    /// Manga status section
    @ViewBuilder
    func statusSection() -> some View {
        Section {
            EnumPicker("", selection: $vm.status)
                .pickerStyle(.menu)
                .buttonStyle(.borderedProminent)
        } header: { Text("STATUS").font(.footnote) }
    }
    
    /// Manga order section
    @ViewBuilder
    func orderSection() -> some View {
        HStack(alignment: .center) {
            // CHAPTER CHOOSER
            self.mangaChapters()
            Spacer()
            Divider().frame(maxHeight: 25)
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
    
    /// Dates section: Started & Ended
    @ViewBuilder
    func dateSection() -> some View {
        DatePicker(selection: $vm.startDate, displayedComponents: [.date]) {
            Label {
                Text("STARTED")
                    .font(.footnote)
                    .lineLimit(1)
            } icon: {
                Image(systemName: "calendar.badge.plus")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
        DatePicker(selection: $vm.endDate, displayedComponents: [.date]) {
            Label {
                Text("ENDED")
                    .font(.footnote)
                    .lineLimit(1)
            } icon: {
                Image(systemName: "calendar")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
