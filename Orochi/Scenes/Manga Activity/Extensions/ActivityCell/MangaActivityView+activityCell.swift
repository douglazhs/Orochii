//
//  MangaActivityView+activityCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI

extension MangaActivityView {
    /// Activity information cell
    @ViewBuilder
    func activityCell() -> some View {
        HStack(spacing: 7.5) {
            self.image()
            self.texts()
        }
    }
    
    /// Manga image
    @ViewBuilder
    func image() -> some View {
        if let url = URL(string: vm.activity?.media?.coverImage?.extraLarge ?? "") {
            AsyncCacheImage(
                url: url,
                averageColor: $vm.averageColor,
                placeholder: { ActivityIndicator() }
            ) { image in
                Image(uiImage: image)
                    .resizable()
            }
            .cornerRadius(4.5)
            .frame(
                width: CGSize.standardImageCell.width,
                height: CGSize.standardImageCell.height,
                alignment: .center
            )
            .scaledToFill()
        }
    }
    
    /// Cell texts
    @ViewBuilder
    func texts() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            HStack(alignment: .top) {
                self.title()
                Spacer()
                self.shareLink()
            }
            Spacer()
            self.date()
        }
    }
    
    /// Share link button
    @ViewBuilder
    func shareLink() -> some View {
        if let url = URL(string: vm.activity?.siteUrl ?? "") {
            ShareLink(item: url) {
                Image(systemName: "square.and.arrow.up")
            }
            .font(.title3)
            .buttonStyle(.borderless)
            .tint(vm.averageColor)
        }
    }
    
    /// Manga title
    @ViewBuilder
    func title() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(vm.activity?.media?.title?.romaji ?? "Unknown")
                .font(.footnote)
                .fontWeight(.semibold)
            Text(vm.activity?.media?.title?.english ?? "No english title")
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
    
    /// Activity Date
    @ViewBuilder
    func date() -> some View {
        Text(Date.getDateBy(
            time: vm.activity?.createdAt ?? 0,
            format: "d MMMM yyyy")
        )
        .font(.caption2)
        .fontWeight(.medium)
        .foregroundColor(Color(uiColor: .systemGray))
    }
}
