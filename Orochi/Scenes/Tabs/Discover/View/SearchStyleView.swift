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
    @Environment(\.isSearching) var isSearching
    @EnvironmentObject var vm: DiscoverViewModel
    @Binding var viewStyle: ViewStyle
    var columns: [GridItem] {
        Array(
            repeating: .init(.adaptive(minimum: 225)),
            count: 2
        )
    }
    
    init(_ viewStyle: Binding<ViewStyle>) {
        _viewStyle = viewStyle
    }
    
    var body: some View {
        content()
            .onReceive(
                vm.$nameQuery
                    .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            ) { _ in
                vm.search()
            }
            .onChange(of: vm.nameQuery) { newValue in
                if !newValue.isEmpty {
                    withTransaction(.init(animation: .easeInOut(duration: 0.225))) {
                        vm.isSearching = true
                    }
                }
            }
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    withAnimation(.easeInOut(duration: 0.175)) {
                        viewStyle = .initial
                        vm.searchResult = nil
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct SearchStyleView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
