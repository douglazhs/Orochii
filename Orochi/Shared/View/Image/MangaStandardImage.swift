//
//  MangaStandardImage.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import NukeUI
import Nuke

struct MangaStandardImage: View {
    var url: URL?
    var size: CGSize?
    var roundCorner: Bool
    
    init(url: URL? = nil, size: CGSize? = nil, roundCorner: Bool = true) {
        self.url = url
        self.size = size
        self.roundCorner = roundCorner
    }
    
    var body: some View {
        LazyImage(
            request: ImageRequest(
                url: url,
                processors: [.resize(width: 295, unit: .points, upscale: true)],
                priority: .veryHigh
            ),
            transaction: .init(animation: .easeIn(duration: 0.5))
        ) { state in
            if let image = state.image {
                sizeVariation(of: image)
            } else {
                if let size {
                    Placeholder().frame(width: size.width, height: size.height)
                } else {
                    Placeholder()
                }
            }
        }
    }
    
    /// Handling image size variation
    @ViewBuilder
    func sizeVariation(of image: Image) -> some View {
        if let size {
            image
                .resizable()
                .scaledToFill()
                .frame(
                    width: size.width,
                    height: size.height
                )
                .clipShape(RoundedRectangle(cornerRadius: roundCorner ? 4.5 : 0.0))
                .overlay {
                    if roundCorner {
                        RoundedRectangle(cornerRadius: 4.5)
                            .stroke(
                                Color(uiColor: .systemGray2),
                                lineWidth: 0.55
                            )
                            .zIndex(1)
                    }
                }
        } else {
            image
                .resizable()
                .scaledToFit()
        }
    }
}

struct MangaStandardImage_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        MangaStandardImage(
            url: URL(
                string: "https://uploads.mangadex.org/covers/c52b2ce3-7f95-469c-96b0-479524fb7a1a/4789ab75-cbce-439d-8344-bd64e80a8e6a.png"
            ),
            size: CGSize(
                width: CGSize.standardImageCell.width,
                height: CGSize.standardImageCell.height
            )
        )
    }
}
