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
            
            VStack(alignment: .leading, spacing: 8.5) {
                MediaAttributes(
                    leading: (title: "FORMAT", value: vm.alManga?.format ?? "-"),
                    trailing: (title: "STATUS", value: vm.alManga?.status ?? "-")
                )
                
                MediaAttributes(
                    leading: (
                        title: "AVERAGE SCORE",
                        value: vm.alManga?.averageScore != nil ?
                        "\(vm.alManga?.averageScore ?? 0)%" :
                        vm.alManga?.averageScore.nilToStr ?? "-"
                    ),
                    trailing: (title: "COUNTRY", value: vm.alManga?.countryOfOrigin ?? "-")
                )
                
                MediaAttributes(
                    leading: (title: "SOURCE", value: vm.alManga?.source?.replacingOccurrences(of: "_", with: " ") ?? "-"),
                    trailing: (title: "YEAR", value: vm.alManga?.startDate?.year.nilToStr ?? "-")
                )
                
                MediaAttributes(
                    leading: (title: "PUPULAR RANK", value: vm.getRank(.popular)),
                    trailing: (title: "RATED RANK", value: vm.getRank(.rated))
                )
            }
        }.lineLimit(1)
    }
}
