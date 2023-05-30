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
    @StateObject var vm = AniListAccountViewModel()
    var user: User?
    
    var body: some View {
        self.content()
            .onAppear {
                guard let user else { return }
                Task { await vm.getPeople(user: user.id) }
            }
    }
}

struct AniListAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AniListAccountView()
    }
}
