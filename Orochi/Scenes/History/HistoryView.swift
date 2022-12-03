//
//  HistoryView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/12/22.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = HistoryViewModel()
    @State var showConfirmAction: Bool = false
    var device = UIDevice.current.userInterfaceIdiom
    
    var body: some View {
        NavigationStack {
            self.content()
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(
                    device == .phone ? .visible : .automatic,
                    for: .navigationBar
                )
                .toolbarBackground(
                    Color.indigo.opacity(0.075),
                    for: .navigationBar
                )
                .scrollContentBackground(.hidden)
                .background(ViewBackground(with: .view_background))
                .toolbar {
                    ToolbarItem(placement: .destructiveAction) {
                        self.clearHistoryButton()
                    }
                }
                .searchable(text: $vm.query)
                .safeAreaInset(edge: .top, alignment: .center) {
                    ActionPopUp(
                        message: MangaActions.history.message,
                        action: $vm.action
                    ).padding(.top, 10)
                }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
