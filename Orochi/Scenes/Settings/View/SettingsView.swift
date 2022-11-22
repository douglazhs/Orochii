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
                    .listRowBackground(Color.clear)
                self.ageRatingSection()
                    .listRowBackground(Color.clear)
                self.icloudSection()
                    .listRowBackground(Color.clear)
                self.securitySection()
                    .listRowBackground(Color.clear)
                self.notificationsSection()
                    .listRowBackground(Color.clear)
            }
            .animation(.easeInOut(duration: 0.175), value: [vm.faceID, vm.logged])
            .background(ViewBackground(name: "aesthetic"))
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
