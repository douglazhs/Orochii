//
//  CoverList.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/24.
//

import SwiftUI
import struct MangaDex.Cover

struct CoverList: View {
    @Environment(\.dismiss)
    var dismiss
    @EnvironmentObject var vm: MangaViewModel
    let columns = [
        GridItem(.adaptive(minimum: CGSize.dynamicImage.width))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 12.5) {
                    ForEach(vm.covers, id: \.id) { cover in
                        NavigationLink(value: cover) {
                            coverGridCell(cover)
                        }
                    }
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(String.Common.done) {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .principal) {
                    Text("All Available Covers")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            .scrollContentBackground(.hidden)
            .overlay(alignment: .center) {
                if vm.loadingCovers {
                    ActivityIndicator()
                } else if !vm.loadingCovers && vm.covers.isEmpty {
                    Text("No other covers available for *\(vm.unwrapTitle(of: vm.manga))*")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.ORCH.primaryText)
                        .padding()
                }
            }
            .background {
                BlurBackground(
                    with: vm.api.buildURL(
                        for: .cover(
                            id: vm.manga.id,
                            fileName: vm.imgFileName(
                                of: vm.manga,
                                quality: vm.coverQuality.key
                            )
                        )
                    ),
                    radius: 50,
                    opacity: 0.75
                )
            }
            .navigationDestination(for: Cover.self) {
                CoverFullScreen($0)
                    .environmentObject(vm)
            }
        }
    }
    
    /// Cover grid cell with image and volume number
    @ViewBuilder
    func coverGridCell(_ cover: Cover) -> some View {
        VStack(alignment: .leading) {
            MangaStandardImage(
                url: vm.api.buildURL(
                    for: .cover(
                        id: vm.manga.id,
                        fileName: vm.imgFileName(
                            of: cover,
                            quality: vm.coverQuality.key
                        )
                    )
                ),
                size: CGSize.dynamicImage,
                roundCorner: true
            )
            
            Group {
                Text("VOL. \(cover.attributes.volume)") +
                Text(" (\(Locale.current.localizedString(forLanguageCode: cover.attributes.locale ?? "") ?? "?"))")
            }
            .font(.subheadline)
            .fontWeight(.regular)
            .foregroundStyle(Color.ORCH.primaryText)
        }
    }
}

#Preview {
    CoverList()
}
