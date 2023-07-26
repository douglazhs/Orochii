//
//  ALTracker+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI
import Combine
import AniListService

extension ALTracker {
    /// All view content
    @ViewBuilder
    func content() -> some View {
        if vm.isTracking {
            trackerInfo()
                .navigationTitle(vm.unwrapTitle(of: vm.mDexManga))
        } else {
            trackerSearch()
                .navigationTitle("Search")
                .searchable(text: $vm.text, placement: .sidebar, prompt: "Search for title in AniList")
                .toolbarBackground(.visible, for: .navigationBar)
                .onSubmit { UIApplication.shared.becomeFirstResponder() }
                .onReceive(
                    vm.$text
                        .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
                ) { value in
                    if !value.isEmpty {
                        vm.searchManga()
                    } else {
                        vm.mangas = nil
                        vm.alManga = nil
                    }
                }
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
    }
    
    /// Tracker search view
    @ViewBuilder
    func trackerSearch() -> some View {
        List {
            if !vm.isLoading {
                if let mangas = vm.mangas, !mangas.isEmpty {
                    ForEach(mangas) { manga in
                        mangaCell(manga)
                            .listRowBackground(Color.clear)
                            .onTapGesture {
                                vm.alManga = vm.alManga == manga ? nil : manga
                            }
                            .overlay(alignment: .trailing) {
                                if vm.alManga == manga {
                                    Image(systemName: "checkmark")
                                        .font(.caption2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.accentColor)
                                }
                            }
                    }
                    .listSectionSeparator(.hidden)
                } else {
                    Text("No results found on **AniList**")
                        .foregroundColor(Color(.systemGray))
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
            }
        }
        .overlay(alignment: .top) {
            if vm.isLoading { ActivityIndicator().padding(.vertical) }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
    }
    
    /// AniList manga cell
    @ViewBuilder
    func mangaCell(_ manga: Media) -> some View {
        HStack(alignment: .top, spacing: 10) {
            MangaStandardImage(
                url: URL(string: manga.coverImage?.large ?? ""),
                size: CGSize.standardImageCell
            )
            
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
                    Text("~ **\(manga.mediaListEntry?.status ?? "")** ~ ON YOUR LIST")
                        .font(.caption2)
                        .foregroundColor(Color(.systemGray))
                        .fontWeight(.regular)
                }
                Text(manga.status ?? "")
                    .font(.caption2)
                    .foregroundColor(Color(.systemGray))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.clear)
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
    
    /// Close screen button
    @ViewBuilder
    func closeButton() -> some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .fontWeight(.heavy)
        }
        .tint(.white)
    }
    
    /// Track manga button
    @ViewBuilder
    func trackButton() -> some View {
        Button {
            vm.verifyTracking()
        } label: { Text("Track").fontWeight(.semibold) }
        .buttonStyle(.borderless)
        .disabled(vm.alManga == nil)
    }
    
    /// Current manga context
    @ViewBuilder
    func pickers() -> some View {
        statesSection()
        dateSection()
    }
}
