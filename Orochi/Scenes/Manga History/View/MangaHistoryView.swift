//
//  MangaHistoryView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI
import struct MangaDex.Manga

struct MangaHistoryView: View {
    @Environment(\.dismiss) var dismiss
    var manga: Manga
    var action: Binding<Bool>
    @State var showConfirmAction: Bool = false
    
    init(of manga: Manga, action: Binding<Bool>) {
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
        EmptyView()
        /*MangaHistoryView(
            of: MangaDomain.samples[0],
            action: .constant(true)
        )*/
    }
}
