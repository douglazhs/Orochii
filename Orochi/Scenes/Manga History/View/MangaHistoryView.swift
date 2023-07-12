//
//  MangaHistoryView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

struct MangaHistoryView: View {
    @Environment(\.dismiss) var dismiss
    var manga: MangaDomain
    var action: Binding<Bool>
    @State var showConfirmAction: Bool = false
    
    init(of manga: MangaDomain, action: Binding<Bool>) {
        self.manga = manga
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            content()
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        clearHistoryButton()
                    }
                }
        }
    }
}

struct MangaHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        MangaHistoryView(
            of: MangaDomain.samples[0],
            action: .constant(true)
        )
    }
}
