//
//  InitialStyleView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

struct InitialStyleView: View {
    @EnvironmentObject var vm: DiscoverViewModel
    @State var showFilter: Bool = false
    var columns = [
        GridItem(.adaptive(minimum: CGSize.standardImageCell.width))
    ]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            filterCarousel()
            
            filterButton()
            
            discoverGrid()
        }
        .sheet(isPresented: $showFilter) {
            DiscoverFilterView()
                .presentationDetents([.medium, .large])
                .presentationCornerRadius(.zero)
                .presentationDragIndicator(.visible)
                .presentationContentInteraction(.resizes)
                .presentationBackgroundInteraction(.disabled)
        }
        .overlay(alignment: .top) {
            if vm.loading {
                IndeterminateProgressView()
            }
        }
    }
}

struct InitialStyleView_Previews: PreviewProvider {
    static var previews: some View {
        InitialStyleView()
            .environmentObject(DiscoverViewModel())
    }
}
