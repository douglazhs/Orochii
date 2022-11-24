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
            Divider()
            VStack(alignment: .center) {
                ForEach(CarouselType.allCases, id: \.self) { type in
                    Section {
                        self.carousel(of: vm.section[type] ?? [])
                            .frame(maxHeight: .infinity)
                    } header: {
                        HStack(alignment: .top) {
                            Text(type.header.uppercased())
                                .font(.callout)
                                .foregroundColor(.primary)
                                .fontWeight(.regular)
                            Spacer()
                        }
                        .padding(.leading)
                    }
                    .frame(maxHeight: .infinity)
                    Divider()
                }
            }
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
