//
//  MangaActivityView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/06/23.
//

import SwiftUI
import AniListService

struct MangaActivityView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm: MangaActivityViewModel
    @State var showAlert: Bool = false
    
    init(_ activity: Int) {
        _vm = StateObject(
            wrappedValue: MangaActivityViewModel(activity)
        )
    }
    
    var body: some View {
        content()
            .toolbar(.hidden, for: .tabBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(
                (vm.activity?.createdAt != nil)
                ? Date.getDate(
                    of: vm.activity?.createdAt ?? 0,
                    format: "EEE, HH:mm"
                )
                : ""
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) { menu() }
            }
            .alert(vm.alertInfo.title, isPresented: $vm.showAlert) {
                Button(String.Common.ok) { if vm.activity == nil { dismiss() } }
            } message: { Text(vm.alertInfo.message) }
            .confirmationDialog(String.Common.attention, isPresented: $showAlert) {
                Button(String.Common.cancel, role: .cancel, action: {})
                Button(String.Common.remove, role: .destructive) {
                    vm.deleteActivity()
                    dismiss()
                }
            } message: { Text("Are you sure you want to delete this activity?") }
            .animation(
                .easeIn(duration: 0.225),
                value: vm.activity != nil
            )
    }
}

struct MangaActivityView_Previews: PreviewProvider {
    static var previews: some View {
        MangaActivityView(550100602)
    }
}
