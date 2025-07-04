//
//  LibraryFilterView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension LibraryFilterView {
    /// Objects to filter results
    /// - Returns: Objects filters
    @ViewBuilder
    func objectFilterSection() -> some View {
        Section {
            EnumPicker(vm.objectFilter.description, selection: $vm.objectFilter).pickerStyle(.inline)
        } header: {
            Text(L.OrderBy.header.uppercased())
        } footer: {
            Text(L.OrderBy.footer)
        }
    }
    
    /// Order elements
    /// - Returns: Order section
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            EnumPicker(L.OrderBy.header, selection: $vm.filterOrder).pickerStyle(.automatic)
        } header: {
            Text(L.OrderBy.header.uppercased())
        }
    }
}
