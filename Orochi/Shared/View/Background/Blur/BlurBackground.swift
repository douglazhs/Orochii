//
//  BlurBackground.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import NukeUI

struct BlurBackground: View {
    var url: URL?
    var image: AppImages = .view_background
    
    init(with url: URL? = nil) { self.url = url }
    
    init(with image: AppImages = .view_background) { self.image = image }
    
    var body: some View {
        if let url {
            ZStack {
                LazyImage(
                    request: ImageRequest(
                        url: url,
                        processors: [.resize(width: 350, unit: .pixels, upscale: true)]
                    ),
                    transaction: .init(animation: .easeIn)
                ) { state in
                    if let image = state.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                            .blur(radius: 35.0, opaque: true)
                    }
                }
                
                Color.black.opacity(0.85).edgesIgnoringSafeArea(.all)
            }
        } else {
            Image(image.rawValue)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .blur(radius: 75)
                .opacity(Constants.device == .pad ? 0.225 : 0.3)
        }
    }
}

struct BlurBackground_Previews: PreviewProvider {
    static var previews: some View {
        BlurBackground(with: .view_background)
    }
}
