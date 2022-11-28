//
//  ViewBackground.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct ViewBackground: View {
    var image: String
    
    init(with image: String) { self.image = image }
    
    init(with image: AppImages) { self.image = image.rawValue }
    
    var body: some View {
        Image(image)
            .resizable(resizingMode: .stretch)
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 75)
            .opacity(0.4)
    }
}

struct ViewBackground_Previews: PreviewProvider {
    static var previews: some View {
        ViewBackground(with: .view_background)
    }
}
