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
            Text(String.Filter.filterByHeader.uppercased())
        }
    }
    
    /// Order elements
    /// - Returns: Order section
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            EnumPicker(String.Filter.orderByHeader, selection: $vm.filterOrder).pickerStyle(.automatic)
        } header: {
            Text(String.Filter.orderByHeader.uppercased())
        }
    }
}
