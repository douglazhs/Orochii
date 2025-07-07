//
//  InitialStyleView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import MangaDex

extension InitialStyleView {
    /// Discover manga grid
    @ViewBuilder
    func discoverGrid() -> some View {
        LazyVGrid(columns: columns, spacing: Constants.device == .pad ? 15.0 : 12.0) {
            ForEach(vm.mangas, id: \.id) { manga in
                NavigationLink {
                    MangaView(manga)
                } label: {
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
                        // TODO: ADD/REMOVE from library
                        print("Context menu action")
                    }
                    .task { [weak vm] in
                        if vm?.hasReachedEnd(
                            of: manga
                        ) ?? false {  vm?.fetchMore() }
                    }
                }
            }
        }.padding([.horizontal, .bottom])
    }
    
    /// Main filrer carousel
    @ViewBuilder
    func filterCarousel() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8.5) {
                ForEach(MainFilter.allCases, id: \.self) {
                    mainFilterCell(filter: $0)
                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 0.5)
        }
    }
    
    /// Discover filter button
    @ViewBuilder
    func filterButton() -> some View {
        HStack {
            Spacer()
            Button("", systemImage: "line.3.horizontal.decrease") {
                showFilter = true
            }
            .padding(.horizontal)
            .padding(.vertical, 10.0)
            .tint(Asset.Colors.button.swiftUIColor)
        }
    }
    
    /// Main filter cell
    @ViewBuilder
    func mainFilterCell(filter: MainFilter) -> some View {
        Button {
            vm.selectedMainFilter = filter
        } label: {
            cellBuild(of: filter)
        }
        .onChange(of: vm.selectedMainFilter) { [weak vm] in
            vm?.fetchSelectedFilter()
        }
    }
    
    ///  Filter cell build
    @ViewBuilder
    func cellBuild(of filter: MainFilter) -> some View {
        Text(filter.header)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(
                vm.selectedMainFilter == filter
                ? Asset.Colors.button.swiftUIColor
                : Asset.Colors.primaryText.swiftUIColor
            )
            .padding(8.5)
            .background(
                vm.selectedMainFilter == filter
                ? Asset.Colors.button.swiftUIColor.opacity(0.25)
                : Asset.Colors.primaryText.swiftUIColor.opacity(0.25)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8.5))
            .overlay(
                RoundedRectangle(cornerRadius: 8.5)
                    .stroke(
                        vm.selectedMainFilter == filter
                        ? Asset.Colors.button.swiftUIColor
                        : Asset.Colors.primaryText.swiftUIColor,
                        lineWidth: 0.5
                    )
            )
    }
}
