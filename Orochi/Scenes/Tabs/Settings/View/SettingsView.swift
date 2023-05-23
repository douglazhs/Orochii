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
            .listStyle(.grouped)
            .toolbarBackground(
                Color.indigo.opacity(0.075),
                for: .navigationBar
            )
            .animation(
                .easeInOut(duration: 0.175),
                value: [vm.biometryPreference, vm.logged]
            )
            .background(BlurBackground(with: .view_background))
            .scrollContentBackground(.hidden)
            .navigationTitle(Text(String.Settings.title))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
