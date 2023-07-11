//
//  DarkOverlay.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/12/22.
//

import SwiftUI

struct DarkOverlay: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable(resizingMode: .tile)
            .aspectRatio(CGSize(width: 9, height: 1), contentMode: .fill)
//            .blur(radius: 4.5, opaque: true)
    }
}

struct DarkOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DarkOverlay(image: "jujutsu")
    }
}
