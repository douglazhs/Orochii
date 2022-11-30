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
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center) {
                ForEach(CarouselType.allCases, id: \.self) { type in
                    Section {
                        self.carousel(of: vm.section[type] ?? [])
                    } header: {
                        HStack(alignment: .center) {
                            Text(type.header.uppercased())
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .fontWeight(.regular)
                                .padding(.trailing, 7.5)
                            VStack { Divider() }
                        }.padding(.leading)
                    }
                }
            }.padding(.vertical)
        }
        .background(ViewBackground(with: .view_background))
        .scrollContentBackground(.hidden)
    }
}

struct InitialStyleView_Previews: PreviewProvider {
    static var previews: some View {
        InitialStyleView()
    }
}
