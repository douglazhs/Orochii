//
//  BlurBackground.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct BlurBackground: View {
    var image: String
    
    init(with image: String) { self.image = image }
    
    init(with image: AppImages) { self.image = image.rawValue }
    
    var body: some View {
        Image(image)
            .resizable(resizingMode: .stretch)
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 75)
            .opacity(0.375)
    }
}

struct BlurBackground_Previews: PreviewProvider {
    static var previews: some View {
        BlurBackground(with: .view_background)
    }
}
