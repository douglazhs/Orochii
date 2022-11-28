//
//  LibraryFilterView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct LibraryFilterView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var vm: LibraryViewModel
    @State var mangaInfoFilter: MangaInfoFilter = .year
    
    var body: some View {
        NavigationStack {
            List {
                self.objectFilterSection()
                    .listRowBackground(Color.clear)
                self.orderSection()
                    .listRowBackground(Color.clear)
                self.mangaInfoSection()
                    .listRowBackground(Color.clear)
            }
            .scrollIndicators(.hidden)
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .background(ViewBackground(with: .view_background))
            .navigationTitle(String.Filter.title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    self.doneButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    self.cancelButton()
                }
            }
        }
        .interactiveDismissDisabled(true)
    }
}

struct LibraryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryFilterView()
    }
}
