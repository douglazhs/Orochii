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
    
    var body: some View {
        self.objectFilterSection()
        self.orderSection()
    }
}


#Preview {
    LibraryFilterView()
        .environmentObject(LibraryViewModel())
}
