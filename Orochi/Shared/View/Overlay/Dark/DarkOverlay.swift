//
//  DarkOverlay.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/12/22.
//

import SwiftUI
import NukeUI

struct DarkOverlay: View {
    var url: URL?
    
    var body: some View {
        ZStack {
            LazyImage(
                request: ImageRequest(
                    url: url,
                    processors: [.resize(width: 295, unit: .points, upscale: true)]
                ),
                transaction: .init(animation: .easeIn)
            ) { state in
                if let image = state.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            }
            
            Color.black.opacity(0.8)
        }
    }
}

struct DarkOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DarkOverlay(url: URL(string: "https://s4.anilist.co/file/anilistcdn/user/banner/b242286-TwkkglJDOtEY.jpg"))
    }
}
