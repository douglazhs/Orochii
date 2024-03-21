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

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(alignment: .leading) {
                ForEach(vm.sections.indices, id: \.self) { index in
                    Section {
                        if let mangas = vm.sections[index].mangas {
                            carousel(index, with: mangas)
                                .padding(.bottom, 25)
                        } else {
                            // TODO: - Placeholder to loading carousel
                        }
                    } header: {
                        Text(vm.sections[index].config.header)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.leading)
                    }
                }
            }.padding(.vertical)
        }
    }
}

struct InitialStyleView_Previews: PreviewProvider {
    static var previews: some View {
        InitialStyleView()
            .environmentObject(DiscoverViewModel())
    }
}
