//
//  MangaStandardImage.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct MangaStandardImage: View {
    var cover: String
    var size: CGSize
    
    var body: some View {
        Image(cover)
            .resizable()
            .frame(
                maxWidth: size.width,
                maxHeight: size.height
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4.5)
                    .stroke(
                        Color(uiColor: .systemGray),
                        lineWidth: 1.05
                    )
            )
            .cornerRadius(4.5)
    }
}

struct MangaStandardImage_Previews: PreviewProvider {
    static var previews: some View {
        MangaStandardImage(
            cover: "jujutsu",
            size: CGSize(
                width: CGSize.standardImageCell.width,
                height: CGSize.standardImageCell.height
            )
        )
    }
}
