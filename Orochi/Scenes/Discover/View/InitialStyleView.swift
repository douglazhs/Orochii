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
        List(CarouselType.allCases, id: \.self) { type in
            Section {
                self.carousel(of: vm.section[type] ?? [])
                    .listRowInsets(EdgeInsets(
                        top: 10,
                        leading: 0,
                        bottom: 10,
                        trailing: 0)
                    )
                    .listRowBackground(Color.clear)
            } header: {
                Text(type.header.uppercased())
                    .font(.callout)
                    .foregroundColor(.primary)
                    .fontWeight(.regular)
            }
        }
        .listStyle(.inset)
        .background(ViewBackground(with: .view_background))
        .scrollContentBackground(.hidden)
    }
}

struct InitialStyleView_Previews: PreviewProvider {
    static var previews: some View {
        InitialStyleView()
    }
}
