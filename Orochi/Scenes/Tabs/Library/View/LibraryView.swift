//
//  LibraryView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.isSearching) 
    var isSearching
    @StateObject var vm: LibraryViewModel
    @State var showFilters: Bool = false
    
    init() {
        _vm = StateObject(wrappedValue: LibraryViewModel())
    }
    
    var body: some View {
        NavigationStack {
            content()
                .onAppear { vm.loadDefaults() }
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
