//
//  ViewBackground.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct ViewBackground: View {
    var name: String
    var body: some View {
        Image(name)
            .resizable(resizingMode: .stretch)
            .edgesIgnoringSafeArea(.all)
            .blur(radius: 75)
            .opacity(0.35)
    }
}

struct ViewBackground_Previews: PreviewProvider {
    static var previews: some View {
        ViewBackground(name: "aesthetic")
    }
}
