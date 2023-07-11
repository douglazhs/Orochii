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
    
    var body: some View {
        NavigationStack {
            self.content()
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
                .scrollContentBackground(.hidden)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        self.clearHistoryButton()
                    }
                }
                .searchable(text: $vm.query, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
