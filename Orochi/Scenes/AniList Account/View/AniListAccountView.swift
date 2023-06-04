//
//  AniListAccountView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI
import struct AniListService.User
import AniListService

/// Account information
struct AniListAccountView: View {
    @StateObject var vm: AniListAccountViewModel
    @State var showAlert: Bool = false
    var user: User?
    
    init(user: User?) {
        _vm = StateObject(wrappedValue: AniListAccountViewModel(user: user))
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        UISegmentedControl.appearance().backgroundColor = .systemIndigo.withAlphaComponent(0.15)
    }
    
    var body: some View {
        self.content()
            .navigationTitle(vm.user?.name ?? "Unknown")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    self.profileWeb()
                }
            }
            .animation(
                .linear(duration: 0.225),
                value: vm.selection
            )
    }
}

struct AniListAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AniListAccountView(user: nil)
    }
}
