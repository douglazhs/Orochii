//
//  SearchStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import NukeUI
import struct MangaDex.Manga

extension SearchStyleView {
    @ViewBuilder
    func content() -> some View {
        ScrollView {
            orderMenu()
            loadedContent(with: vm.orderedSearchResult)
        }
        .overlay(alignment: .top) {
            if vm.isSearching {
                IndeterminateProgressView()
            }
        }
    }
    
    @ViewBuilder
    func loadedContent(with mangas: [Manga]) -> some View {
        LazyVGrid(columns: columns, spacing: Constants.device == .pad ? 15.0 : 12.0) {
            ForEach(mangas) { manga in
                NavigationLink(value: manga) {
                    GridCell(
                        coverURL: vm.api.buildURL(for: .cover(
                            id: manga.id,
                            fileName: vm.imgFileName(
                                of: manga,
                                quality: vm.mDexCoverQuality.key
                            )
                        )),
                        title: vm.unwrapTitle(of: manga)
                    ) {
                        // TODO: - ADD/REMOVE from library
                        print("Context menu action")
                    }
                }
            }
        }
        .padding([.horizontal, .bottom])
        .navigationDestination(for: Manga.self) {
            MangaView($0)
        }
    }
    
    @ViewBuilder
    func searchHandler() -> some View {
        if !vm.isSearching && isSearching {
            Text("No results found for: *\(vm.nameQuery)*")
                .lineLimit(1)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
                .padding(.vertical)
                .frame(maxWidth: .infinity)
        }
    }
    
    @ViewBuilder
    func orderButton() -> some View {
        Image(systemName: "line.3.horizontal.decrease")
            .padding(.horizontal)
            .padding(.vertical, 15.0)
            .tint(Asset.Colors.button.swiftUIColor)
    }
    
    @ViewBuilder 
    func orderMenu() -> some View {
        HStack {
            Spacer()
            
            Menu {
                customOrderSection()
                noOrderSection()
            } label: {
                orderButton()
            }
            .onChange(of: vm.searchOrder) { _ in
                vm.ascendingOrder = true
                vm.orderSearchResult()
            }
            .onChange(of: vm.ascendingOrder) { _ in
                vm.orderSearchResult()
            }
        }
    }
    
    @ViewBuilder
    func customOrderSection() -> some View {
        Section {
            Button {
                vm.searchOrder = .title
                vm.ascendingOrder.toggle()
            } label: {
                Text("Title")
                    .overlay(alignment: .trailing) {
                        if vm.searchOrder == .title {
                            Image(systemName: vm.ascendingOrder ? "chevron.down" : "chevron.up")
                        }
                    }
            }
            
            Button {
                vm.searchOrder = .lastUpdated
                vm.ascendingOrder.toggle()
            } label: {
                Text("Last Updated")
                    .overlay(alignment: .trailing) {
                        if vm.searchOrder == .lastUpdated {
                            Image(systemName: vm.ascendingOrder ? "chevron.down" : "chevron.up")
                        }
                    }
            }
        } header: {
            Text(String.Filter.orderByHeader)
        }
    }
    
    @ViewBuilder
    func noOrderSection() -> some View {
        Section {
            Button { vm.searchOrder = .none } label: {
                Text(String.Common.none)
                    .overlay {
                        if vm.searchOrder == .none {
                            Image(systemName: "checkmark")
                        }
                    }
            }
            .tint(.white)
        } header: {
            Text("No filter")
        }
    }
}
