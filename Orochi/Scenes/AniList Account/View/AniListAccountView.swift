//
//  AniListAccountView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI
import AniListService

/// Account information
struct AniListAccountView: View {
    var user: User?
    
    var body: some View {
        self.content()
    }
}

struct AniListAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AniListAccountView()
    }
}
