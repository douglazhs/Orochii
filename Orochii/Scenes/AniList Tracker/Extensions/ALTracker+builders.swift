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
            .overlay { trackLocallyOverlay() }
            .fullScreenCover(isPresented: $showWebView) {
                if let url = vm.alUrl {
                    SafariWebView(url: url)
                        .ignoresSafeArea()
                }
            }
    }
    
    /// Search screen
    @ViewBuilder
    func search() -> some View {
        trackerSearchList()
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
    
    /// Tracking manga view
    @ViewBuilder
    func trackerInfoList() -> some View {
        List {
            // MANGA INFORMATION
            mangaSection()
                .listRowSeparator(.hidden)
            // ANILIST ACTIONS
            pickers()
                .listRowSeparator(.hidden)
        }
        .listStyle(.inset)
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
                    Text(L.Tracker.Search.noResults.attributedString)
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
            }
        }
        .navigationTitle(vm.buildTitle())
        .listStyle(.inset)
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
