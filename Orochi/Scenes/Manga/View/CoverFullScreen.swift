//
//  CoverFullScreen.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/24.
//

import SwiftUI
import struct MangaDex.Cover
import class MangaDex.CoverMock

struct CoverFullScreen: View {
    @EnvironmentObject var vm: MangaViewModel
    var cover: Cover
    
    init(_ cover: Cover) {
        self.cover = cover
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                coverInfo()
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
                    roundCorner: false
                )
            }
            .padding()
            .navigationTitle("VOL. \(cover.attributes.volume)")
        }
        .background {
            BlurBackground(
                with: vm.api.buildURL(
                    for: .cover(
                        id: vm.manga.id,
                        fileName: vm.imgFileName(
                            of: cover,
                            quality: vm.coverQuality.key
                        )
                    )
                ),
                radius: 50,
                opacity: 0.75
            )
        }
    }
    
    /// Cover main information
    @ViewBuilder
    func coverInfo() -> some View {
        VStack(alignment: .leading, spacing: 7.5) {
            Text("\(Locale.current.localizedString(forLanguageCode: cover.attributes.locale ?? "") ?? "?")")
                .font(.headline)
                .multilineTextAlignment(.center)
                .fontWeight(.heavy)
            VStack(alignment: .leading) {
                Text("Updated at: \(Date.fromString(cover.attributes.updatedAt ?? ""))")
                Text("Created at: \(Date.fromString(cover.attributes.updatedAt ?? ""))")
                Text("Version: \(cover.attributes.version.nilToStr)")
                if let description = cover.attributes.description, !description.isEmpty {
                    Text("Description: \(vm.attributedString(description))")
                }
            }
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .fontWeight(.medium)
            .foregroundStyle(Color.ORCH.primaryText)
        }
    }
}

#Preview {
    CoverFullScreen(CoverMock.cover)
}
