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
            .background(
                BlurBackground(
                    with: URL(
                        string: vm.alManga?.bannerImage ??
                        vm.alManga?.coverImage?.large ??
                        ""
                    ),
                    radius: Constants.device == .phone ? 8.5 : 15
                )
            )
            .toolbarBackground(.visible, for: .navigationBar)
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
            .background {
                BlurBackground(
                    with: cover,
                    radius: Constants.device == .phone ? 30 : 50
                )
            }
            .searchable(
                text: $vm.text,
                prompt: "Search for title in AniList"
            )
            .toolbarBackground(.visible, for: .navigationBar)
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
                    
                    if let english = vm.alManga?.title?.english,
                       (english != vm.alManga?.title?.romaji ?? "") {
                        Text(english)
                            .foregroundColor(.secondary)
                            .font(.caption2)
                            .fontWeight(.medium)
                    }
                }
            case .search: Text("Search").font(.headline)
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
                        .foregroundColor(Color(.systemGray))
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
