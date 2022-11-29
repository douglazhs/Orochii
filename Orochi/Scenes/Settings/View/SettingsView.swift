//
//  SettingsView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vm: SettingsViewModel = SettingsViewModel()
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
            .animation(.easeInOut(duration: 0.175), value: [vm.biometry, vm.logged])
            .background(ViewBackground(with: .view_background))
            .scrollContentBackground(.hidden)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.editor)
            .navigationTitle(Text(String.Settings.title))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
