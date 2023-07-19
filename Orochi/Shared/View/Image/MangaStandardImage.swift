//
//  MangaStandardImage.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaStandardImage: View {
    var url: URL?
    var size: CGSize
    
    var body: some View {
        if let url {
            AsyncImage(url: url, placeholder: { Placeholder() })
                .scaledToFill()
                .frame(
                    width: size.width,
                    height: size.height
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 4.5)
                        .stroke(
                            Color(uiColor: .systemGray3),
                            lineWidth: 1.05
                        )
                )
                .cornerRadius(4.5)
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
