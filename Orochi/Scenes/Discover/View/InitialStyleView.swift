//
//  InitialStyleView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

struct InitialStyleView: View {
    @EnvironmentObject var vm: DiscoverViewModel

    var body: some View {
        List(CarouselType.allCases, id: \.self) { carousel in
            Section {
                self.carousel(of: vm.mangas)
                    .listRowInsets(EdgeInsets(
                        top: 10,
                        leading: 0,
                        bottom: 10,
                        trailing: 0)
                    )
                    .listRowBackground(Color.clear)
            } header: {
                Text(carousel.header.uppercased())
                    .font(.callout)
                    .foregroundColor(.primary)
                    .fontWeight(.regular)
            }
        }
        .listStyle(.inset)
        .background(ViewBackground(name: "aesthetic"))
        .scrollContentBackground(.hidden)
    }
}

struct InitialStyleView_Previews: PreviewProvider {
    static var previews: some View {
        InitialStyleView()
    }
}
