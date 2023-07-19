//
//  ALTracker+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI
import AniListService

extension ALTracker {
    /// All view content
    @ViewBuilder
    func content() -> some View {
        if vm.tracking() {
            trackerInfo()
                .navigationTitle(vm.mDexManga.attributes?.title?.en ?? "Unknown")
        } else {
            trackerSearch()
                .searchable(text: $vm.text, prompt: "Search for title in AniList")
                .onSubmit { vm.searchManga() }
        }
    }
    
    /// Tracking manga view
    @ViewBuilder
    func trackerInfo() -> some View {
        List {
            // MANGA INFORMATION
            mangaSection()
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            // ANILIST ACTIONS
            pickers()
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(BlurBackground(with: .view_background))
    }
    
    /// Tracker search view
    @ViewBuilder
    func trackerSearch() -> some View {
        if let mangas = vm.mangas {
            List(mangas) { manga in
                mangaCell(manga)
                    .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .background(BlurBackground(with: .view_background))
        }
    }
    
    /// AniList manga cell
    @ViewBuilder
    func mangaCell(_ manga: Media) -> some View {
        HStack(alignment: .top, spacing: 10) {
            if let url = URL(string: manga.coverImage?.large ?? "") {
                MangaStandardImage(
                    url: url,
                    size: CGSize.standardImageCell
                )
            }
            VStack(alignment: .leading, spacing: 3.5) {
                Text(manga.title?.romaji ?? "Unknown")
                    .lineLimit(2)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text("\(manga.title?.english ?? "No english title")")
                    .lineLimit(1)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.systemGray))
                HStack(alignment: .center) {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10.0, height: 10.0)
                    Text("\((manga.averageScore ?? 0) / 10)")
                        .font(.caption2)
                }
                if manga.mediaListEntry != nil {
                    Text("Set as **\(manga.mediaListEntry?.status ?? "")** by you")
                        .font(.caption2)
                        .foregroundColor(Color(.systemGray))
                        .fontWeight(.regular)
                }
                Text(manga.status ?? "")
                    .font(.caption2)
                    .foregroundColor(Color(.systemGray))
            }
        }
    }
    
    /// Update anilist button
    @ViewBuilder
    func updateTrackingButton() -> some View {
        Button {
            // TODO: - Save changes
            withAnimation(.easeInOut(duration: 0.175)) {
                action.wrappedValue = true
            }
            Haptics.shared.notify(.success)
            isPresented = false
        } label: { Text("Update").fontWeight(.semibold) }
        .buttonStyle(.borderless)
    }
    
    /// Track manga button
    @ViewBuilder
    func trackButton() -> some View {
        Button {
            
        } label: { Text("Track").fontWeight(.semibold).disabled(vm.manga == nil) }
        .buttonStyle(.borderless)
    }
    
    /// Current manga context
    @ViewBuilder
    func pickers() -> some View {
        statesSection()
        dateSection()
    }
}
