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
                .standardBars()
                .animation(.spring(), value: [vm.isLoading, vm.user != nil])
                .alert(vm.alertInfo.title, isPresented: $vm.showAlert) {
                    Button(String.Common.ok) { }
                } message: { Text(vm.alertInfo.message) }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text(String.Adjusts.title)
                            .font(.title2)
                            .fontWeight(.heavy)
                    }
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
