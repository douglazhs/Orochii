//
//  SettingsView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vm: SettingsViewModel = SettingsViewModel()
    @State var showErrorDialog: Bool = false
    @State var showDialog: Bool = false
    @State var showALAccount: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                self.anilistSection()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                self.icloudSection()
                    .listRowBackground(Color.clear)
                self.securitySection()
                    .listRowBackground(Color.clear)
                self.notificationsSection()
                    .listRowBackground(Color.clear)
            }
            .refreshable {
                Task { await vm.checkALToken() }
            }
            .listStyle(.grouped)
            .navigationTitle(String.Settings.title)
            .navigationBarTitleDisplayMode(.inline)
            .animation(
                .easeInOut(duration: 0.175),
                value: [
                    vm.biometryPreference,
                    vm.logged,
                    vm.isLoading
                ]
            )
            .background(BlurBackground(with: .view_background))
            .scrollContentBackground(.hidden)
        }
        .tint(Color.white)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
