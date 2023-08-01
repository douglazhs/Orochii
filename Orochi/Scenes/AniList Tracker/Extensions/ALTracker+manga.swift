//
//  ALTrackerView+manga.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension ALTracker {
    /// Manga information
    @ViewBuilder
    func mangaSection() -> some View {
        HStack(alignment: .top, spacing: 12.5) {
            // MANGA COVER
            MangaStandardImage(
                url: URL(
                    string: vm.alManga?.coverImage?.extraLarge ??
                    vm.alManga?.coverImage?.large ??
                    ""
                ),
                size: CGSize(
                    width: CGSize.standardImageCell.width * 1.5,
                    height: CGSize.standardImageCell.height * 1.5
                )
            )
            
            VStack(alignment: .leading, spacing: 10.0) {
                MediaAttributes(
                    leading: (title: "FORMAT", value: vm.alManga?.format ?? "-"),
                    trailing: (title: "STATUS", value: vm.alManga?.status ?? "-")
                )
                
                MediaAttributes(
                    leading: (
                        title: "AVERAGE SCORE",
                        value: String(format: "%.1f", Double(vm.alManga?.averageScore ?? 0) / 10.0)
                    ),
                    trailing: (title: "COUNTRY", value: vm.alManga?.countryOfOrigin ?? "-")
                )
                
                MediaAttributes(
                    leading: (title: "SOURCE", value: vm.alManga?.source?.replacingOccurrences(of: "_", with: " ") ?? "-"),
                    trailing: (title: "YEAR", value: vm.alManga?.startDate?.year?.unwrapNil() ?? "-")
                )
                
                MediaAttributes(
                    leading: (title: "PUPULAR", value: "#\(vm.getRank(.popular)?.unwrapNil() ?? "-")"),
                    trailing: (title: "RATED", value: "#\(vm.getRank(.rated)?.unwrapNil() ?? "-")")
                )
            }
        }.lineLimit(1)
    }
}
