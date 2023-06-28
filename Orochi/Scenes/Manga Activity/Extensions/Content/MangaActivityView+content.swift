//
//  MangaActivityView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/06/23.
//

import SwiftUI
import Kingfisher

extension MangaActivityView {
    @ViewBuilder
    func content() -> some View {
        if vm.activity != nil {
            VStack(spacing: .zero) {
                elements()
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                if !vm.isLoading { textEditor() }
            }
        } else {
            ZStack {
                ActivityIndicator()
                BlurBackground(with: .view_background)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    /// Scene main elements
    @ViewBuilder
    func elements() -> some View {
        let statusString: String =
        (vm.activity?.status ?? "")
        + " "
        + (vm.activity?.progress ?? "")
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Text(vm.activity != nil ? statusString.capitalized : "No status")
                    .font(.callout)
                    .fontWeight(.medium)
                    .padding(.vertical, 7.5)
                    .padding(.horizontal)
                activityCell().padding(.horizontal)
                actions().padding(.horizontal)
                if vm.activity?.likeCount != 0 { likesCarousel() }
                Divider().padding()
                replies()
            }
        }
        .refreshable { vm.refresh() }
        .scrollContentBackground(.hidden)
    }
    
    /// Background image
    @ViewBuilder
    func background() -> some View {
        if let url = URL(string: vm.activity?.media?.bannerImage ?? "") {
            KFImage.url(url)
                .fromMemoryCacheOrRefresh()
                .cacheMemoryOnly()
                .memoryCacheExpiration(.seconds(10))
                .fade(duration: 0.375)
                .forceTransition()
                .startLoadingBeforeViewAppear()
                .resizable()
            .edgesIgnoringSafeArea(.all)
            .scaledToFill()
            .blendMode(.overlay)
            .blur(radius: 25)
            .opacity(0.175)
        } else { BlurBackground(with: .view_background) }
    }
}
