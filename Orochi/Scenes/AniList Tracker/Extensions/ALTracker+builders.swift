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
        if !vm.loadingById {
            if vm.availableInAL {
                aniList()
            } else {
                search()
            }
        } else { ActivityIndicator() }
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
            .confirmationDialog(
                "Stop tracking locally",
                isPresented: $showConfirmation,
                titleVisibility: .visible
            ) {
                Button("Stop", role: .destructive) { dismiss() }
            } message : {
                Text("You will not lose your AniList progress, just remove the track information locally.")
            }
            .overlay { trackLocallyOverlay() }
    }
    
    /// AniList title view
    @ViewBuilder
    func alTitleView() -> some View {
        Group {
            if vm.availableInAL {
                VStack(spacing: .zero) {
                    Text(
                        vm.alManga?.title?.romaji ??
                        vm.alManga?.title?.english ??
                        (vm.loadingById ? "" : "Unknown")
                    )
                    
                    if let english = vm.alManga?.title?.english,
                       (english != vm.alManga?.title?.romaji ?? "") {
                        Text(english)
                            .foregroundColor(.secondary)
                            .font(.caption2)
                            .fontWeight(.medium)
                    }
                }
            } else { Text("Search").font(.headline) }
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .lineLimit(1)
    }
    
    /// Search screen
    @ViewBuilder
    func search() -> some View {
        trackerSearchList()
            .background(BlurBackground(with: cover))
            .navigationTitle("Search")
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
            textField()
            if !vm.loadingByText {
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
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
    }
    
    /// Search text field
    @ViewBuilder
    func textField() -> some View {
        TextField("", text: $vm.text, prompt: Text("Search for title in **AniList**"))
            .onReceive(
                vm.$text
                    .debounce(
                        for: .seconds(1.0),
                        scheduler: DispatchQueue.main
                    )
            ) { value in
                if !value.isEmpty {
                    vm.searchManga()
                } else {
                    vm.clearSearch()
                }
            }
            .padding(.bottom, 5.0)
            .overlay(alignment: .bottom) {
                Divider()
            }
            .overlay(alignment: .trailing) {
                if !vm.text.isEmpty {
                    Button {
                        vm.clearSearch()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.primary)
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
            .listRowBackground(Color.clear)
            /*.overlay(alignment: .bottom) {
                if vm.loadingByText {
                    ActivityIndicator()
                }
            }*/
    }
    
    /// Current manga context
    @ViewBuilder
    func pickers() -> some View {
        mainStates()
        secondaryStates()
    }
}
