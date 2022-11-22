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
    var aspectRatio: CGFloat
    
    var body: some View {
        Image(cover)
            .resizable()
            .frame(
                maxWidth: size.width,
                maxHeight: size.height * aspectRatio
            )
            .overlay(
                RoundedRectangle(cornerRadius: 3.5)
                    .stroke(
                        Color(uiColor: .systemGray),
                        lineWidth: 0.5
                    )
            )
            .cornerRadius(3.5)
    }
}

struct MangaStandardImage_Previews: PreviewProvider {
    static var previews: some View {
        MangaStandardImage(
            cover: "jujutsu",
            size: CGSize(
                width: 175,
                height: 225
            ),
            aspectRatio: (225.0 / 175.0)
        )
    }
}
