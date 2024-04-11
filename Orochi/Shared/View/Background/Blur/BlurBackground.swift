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
    var image: AppImages = .viewBackground
    var radius: Double
    
    init(with url: URL? = nil, radius: Double = 55.0) {
        self.url = url
        self.radius = radius
    }
    
    init(with image: AppImages = .viewBackground, radius: Double = 55.0) {
        self.image = image
        self.radius = radius
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
                
                Color.black.opacity(0.9).edgesIgnoringSafeArea(.all)
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
        BlurBackground(with: .viewBackground)
    }
}
