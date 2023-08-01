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
            .fontDesign(.rounded)
            .navigationTitle(
                vm.alManga?.title?.romaji ??
                vm.alManga?.title?.english ??
                ""
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .alert("Chapter", isPresented: $showTextField) {
                TextField("", value: $vm.chapter, formatter: vm.textFieldformatter())
                    .keyboardType(.numberPad)
                Text("Total")
            } message: {
                Text("Total: \(vm.alManga?.chapters != nil ? "\(vm.alManga?.chapters ?? 0)" : "-")")
            }
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
    
    /// Search screen
    @ViewBuilder
    func search() -> some View {
        trackerSearchList()
            .background(BlurBackground(with: cover))
            .navigationTitle("Search")
            .searchable(text: $vm.text, placement: .automatic, prompt: "Search for title in AniList")
            .toolbarBackground(.visible, for: .navigationBar)
            .onSubmit { UIApplication.shared.becomeFirstResponder() }
            .onTapGesture { UIApplication.shared.becomeFirstResponder() }
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
        .overlay(alignment: .top) {
            if vm.loadingByText { ActivityIndicator().padding(.vertical) }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
    }
    
    /// Current manga context
    @ViewBuilder
    func pickers() -> some View {
        mainStates()
        secondaryAttributes()
    }
}
