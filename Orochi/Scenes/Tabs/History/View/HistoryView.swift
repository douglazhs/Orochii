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
                .background(BlurBackground(with: .view_background))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        self.clearHistoryButton()
                    }
                    ToolbarItem(placement: .principal) {
                        ActionPopUp(
                            title: "History",
                            message: "Successfully Cleared",
                            action: $vm.action
                        )
                    }
                }
                .searchable(text: $vm.query)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
