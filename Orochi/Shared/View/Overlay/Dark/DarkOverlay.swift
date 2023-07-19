//
//  DarkOverlay.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/12/22.
//

import SwiftUI

struct DarkOverlay: View {
    var url: URL?
    
    var body: some View {
        if let url {
            AsyncImage(url: url, placeholder: { ActivityIndicator() })
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct DarkOverlay_Previews: PreviewProvider {
    static var previews: some View {
        DarkOverlay(url: nil)
    }
}
