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
    @ObservedObject var vm: AniListAccountViewModel
    @State var showAlert: Bool = false
    
    init(user: User?) {
        vm = AniListAccountViewModel(user: user)
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
                .interactiveSpring(dampingFraction: 1.75),
                value: vm.selection
            )
            .onAppear {
                guard let user = vm.user else { return }
                vm.unwrapStats()
                Task { await vm.getPeople(user: user.id) }
            }
    }
}

struct AniListAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AniListAccountView(user: nil)
    }
}
