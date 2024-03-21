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
        switch vm.context {
        case .tracker: aniList()
        case .search: search()
        }
    }
    
    /// AniList screen
    @ViewBuilder
    func aniList() -> some View {
        trackerInfoList()
            .background(Color("background"))
            .fullScreenCover(isPresented: $showWebView) {
                SafariWebView(url: vm.alUrl!)
                    .ignoresSafeArea()
            }
            .overlay { trackLocallyOverlay() }
    }
    
    /// Search screen
    @ViewBuilder
    func search() -> some View {
        trackerSearchList()
            .background(Color("background"))
            .searchable(
                text: $vm.text,
                prompt: "Search for title in AniList"
            )
            .onReceive(
                vm.$text
                    .debounce(
                        for: .seconds(0.75),
                        scheduler: DispatchQueue.main
                    )
            ) { [weak vm] in
                if !$0.isEmpty {
                    vm?.searchManga()
                } else {
                    vm?.clearSearch()
                }
            }
    }
    
    /// AniList title view
    @ViewBuilder
    func alTitleView() -> some View {
        Group {
            switch vm.context {
            case .tracker:
                VStack(spacing: .zero) {
                    Text(
                        vm.alManga?.title?.romaji ??
                        vm.alManga?.title?.english ??
                        (vm.isLoading ? "" : "Unknown")
                    )
                    .font(.headline)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.heavy)
                    
                    if let english = vm.alManga?.title?.english,
                       (english != vm.alManga?.title?.romaji ?? "") {
                        Text(english)
                            .font(.caption2)
                            .fontWeight(.medium)
                    }
                }
            case .search: 
                Text("Search")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .lineLimit(1)
    }
    
    /// Tracking manga view
    @ViewBuilder
    func trackerInfoList() -> some View {
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
    func trackerSearchList() -> some View {
        List {
            if let mangas = vm.mangas, !mangas.isEmpty, !vm.isSearching {
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
                if !vm.isSearching {
                    Text("No results found on **AniList**")
                        .foregroundColor(Color("bodyText"))
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .overlay(alignment: .top) {
            if vm.isSearching {
                ActivityIndicator().padding(.vertical)
            }
        }
    }
    
    /// Current manga context
    @ViewBuilder
    func pickers() -> some View {
        mainStates()
        secondaryStates()
    }
}
