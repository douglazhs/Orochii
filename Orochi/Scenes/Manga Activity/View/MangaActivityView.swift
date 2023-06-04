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
    @State var showLikes: Bool = false
    @State var showAlert: Bool = false
    
    init(_ activity: Int) {
        _vm = StateObject(
            wrappedValue: MangaActivityViewModel(activity)
        )
    }
    
    var body: some View {
        self.content()
            .onTapGesture { UIApplication.shared.endEditing() }
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(
                vm.averageColor.opacity(0.15),
                for: .navigationBar
            )
            .navigationTitle(Date.getDateBy(
                time: vm.activity?.createdAt ?? 0,
                format: "EEE, HH:mm")
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    self.menu()
                }
            }
            .alert(
                String.Common.attention,
                isPresented: $showAlert
            ) {
                Button(String.Common.cancel, role: .cancel, action: {})
                Button(String.Common.remove, role: .destructive) {
                    vm.deleteActivity()
                    self.dismiss()
                }
            } message: {
                Text("Are you sure you want to delete this activity?")
            }
    }
}

struct MangaActivityView_Previews: PreviewProvider {
    static var previews: some View {
        MangaActivityView(0)
    }
}
