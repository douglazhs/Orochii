//
//  AsyncImageView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 10/06/24.
//

import SwiftUI
import NukeUI
import class MangaDex.MangaMock

struct AsyncImageView: View {
    var url: URL?
    var size: CGSize?
    
    init(url: URL? = nil, size: CGSize? = nil) {
        self.url = url
        self.size = size
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
                if let size {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: size.width,
                            height: size.height
                        )
                } else {
                    image
                        .resizable()
                        .scaledToFill()
                }
            } else {
                if let size {
                    Placeholder().frame(width: size.width, height: size.height)
                } else {
                    Placeholder(overlay: false)
                        .frame(
                            width: CGSize.standardImageCell.width,
                            height: CGSize.standardImageCell.height
                        )
                }
            }
        }
    }
}

#Preview {
    AsyncImageView(url: MangaMock.coverUrl, size: .standardImageCell)
}
