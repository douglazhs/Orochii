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
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: AniListAccountViewModel
    @State var showBio: Bool = false
    
    init(_ user: Int) {
        _vm = StateObject(
            wrappedValue: AniListAccountViewModel(user)
        )
        UISegmentedControl.appearance().selectedSegmentTintColor = .systemIndigo
        UISegmentedControl.appearance().backgroundColor = .systemIndigo.withAlphaComponent(0.15)
    }
    
    var body: some View {
        content()
            .navigationTitle(vm.user != nil ? vm.user?.name ?? "Unknown" : "")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    profileWeb()
                }
            }
            .alert(vm.alertInfo.title, isPresented: $vm.showAlert) {
                Button(String.Common.ok) {
                    if let error = vm.requestError as? HTTPStatusCode {
                        if error == .notFound { dismiss() }
                    }
                }
            } message: { Text(vm.alertInfo.message) }
            .animation(
                .easeIn(duration: 0.225),
                value: vm.user != nil
            )
    }
}

struct AniListAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AniListAccountView(0)
    }
}
