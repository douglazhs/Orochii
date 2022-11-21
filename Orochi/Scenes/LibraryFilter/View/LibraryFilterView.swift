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
    @State var mangaInfoFilter: MangaInfoFilter = .language
    
    var body: some View {
        NavigationView {
            List {
                self.objectFilterSection()
                self.orderSection()
                self.mangaInfoSection()
                
            }
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
