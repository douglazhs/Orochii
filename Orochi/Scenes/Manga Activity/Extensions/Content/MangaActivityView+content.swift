//
//  MangaActivityView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/06/23.
//

import SwiftUI

extension MangaActivityView {
    @ViewBuilder
    func content() -> some View {
        let statusString: String =
        (vm.activity?.status ?? "")
        + " "
        + (vm.activity?.progress ?? "")
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(statusString.capitalized)
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.vertical, 7.5)
                self.activityCell()
                self.actions()
                Divider()
                self.textEditor()
                Divider()
                self.replies()
            }.padding(.horizontal)
        }
        .refreshable { vm.refresh() }
        .scrollContentBackground(.hidden)
        .background { self.background() }
    }
    
    /// Background image
    @ViewBuilder
    func background() -> some View {
        if let url = URL(string: vm.activity?.media?.coverImage?.extraLarge ?? "") {
            AsyncCacheImage(
                url: url,
                placeholder: { BlurBackground(with: .view_background) }
            ) { image in
                Image(uiImage: image)
                    .resizable()
            }
            .edgesIgnoringSafeArea(.all)
            .scaledToFill()
            .blendMode(.overlay)
            .blur(radius: 55)
            .opacity(0.175)
        } else { BlurBackground(with: .view_background) }
    }
}
