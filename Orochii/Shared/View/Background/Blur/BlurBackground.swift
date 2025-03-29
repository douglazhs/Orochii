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
    var image: Image = Asset.Assets.viewBackground.swiftUIImage
    var radius: Double
    var opacity: Double
    
    init(
        with url: URL? = nil,
        radius: Double = 55.0,
        opacity: Double = 0.8
    ) {
        self.url = url
        self.radius = radius
        self.opacity = opacity
    }
    
    init(
        with image: Image = Asset.Assets.viewBackground.swiftUIImage,
        radius: Double = 55.0,
        opacity: Double =  0.9
    ) {
        self.image = image
        self.radius = radius
        self.opacity = opacity
    }
    
    var body: some View {
        if let url {
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
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                            .blur(radius: radius, opaque: true)
                    }
                }
                
                Color.black.opacity(opacity).edgesIgnoringSafeArea(.all)
            }
        } else {
            image
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
        BlurBackground(with: Asset.Assets.viewBackground.swiftUIImage)
    }
}
