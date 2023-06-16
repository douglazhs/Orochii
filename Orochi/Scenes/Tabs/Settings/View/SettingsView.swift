//
//  SettingsView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

enum SettingsSelection {
    
}

struct SettingsView: View {
    @StateObject var vm: SettingsViewModel = SettingsViewModel()
    @State var showALAccount: Bool = false
    
    var body: some View {
        NavigationStack {
            content()
                .navigationBarTitleDisplayMode(.inline)
                .alert(vm.alertInfo.title, isPresented: $vm.showAlert) {
                    Button(String.Common.ok) { }
                } message: { Text(vm.alertInfo.message) }
                .confirmationDialog(String.Common.attention, isPresented: $vm.showDialog) {
                    Button(String.Common.cancel, role: .cancel, action: {})
                    Button(String.Adjusts.logOut, role: .destructive) {
                        vm.logOutAL()
                    }
                } message: { Text(String.Anilist.logOutMessage) }
                
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
