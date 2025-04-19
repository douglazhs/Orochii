//
//  SettingsView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var vm: SettingsViewModel = SettingsViewModel()
    @State var showALAccount: Bool = false
    
    var body: some View {
        NavigationStack {
            content()
                .standardBars(
                    title: L.Adjusts.title,
                    isOpaque: Constants.device == .pad ? false : true
                )
                .animation(.spring(), value: [vm.isLoading, vm.user != nil])
                .alert(vm.alertInfo.title, isPresented: $vm.showAlert) {
                    Button(L.Common.ok) { }
                } message: {
                    Text(vm.alertInfo.message)
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
