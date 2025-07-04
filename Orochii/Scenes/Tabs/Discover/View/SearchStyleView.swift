//
//  SearchStyleView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import Combine
import struct MangaDex.Manga

struct SearchStyleView: View {
    @Environment(\.isSearching) 
    var isSearching
    @EnvironmentObject var vm: DiscoverViewModel
    @Binding var viewStyle: ViewStyle
    @State var showFilter: Bool = false
    var columns = [
        GridItem(.adaptive(minimum: CGSize.standardImageCell.width))
    ]
    
    init(_ viewStyle: Binding<ViewStyle>) {
        _viewStyle = viewStyle
    }
    
    var body: some View {
        content()
            .onReceive(
                vm.$nameQuery
                    .debounce(
                        for: .seconds(0.75),
                        scheduler: DispatchQueue.main
                    )
            ) { [weak vm] _ in vm?.search() }
            .onChange(of: vm.nameQuery) { _, newValue in
                if !newValue.isEmpty {
                    withTransaction(.init(animation: .easeIn(duration: 0.25))) {
                        vm.isSearching = true
                    }
                }
            }
            .onChange(of: isSearching) { _, newValue in
                if !newValue {
                    vm.isSearching = false
                    vm.searchResult?.removeAll()
                    viewStyle = .initial
                }
            }
    }
}

#Preview {
    SearchStyleView(.constant(.search))
        .environmentObject(DiscoverViewModel())
}
