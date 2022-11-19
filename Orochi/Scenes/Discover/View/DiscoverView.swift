//
//  DiscoverView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct DiscoverView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Discover")
            }.navigationTitle(Text("Discover"))
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
