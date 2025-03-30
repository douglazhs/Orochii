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
            
            attributes()
        }.lineLimit(1)
    }
    
    @ViewBuilder
    func attributes() -> some View {
        VStack(alignment: .leading, spacing: 8.5) {
            MediaAttributes(
                leading: (title: L.Tracker.Manga.format, value: vm.alManga?.format ?? "-"),
                trailing: (title: L.Tracker.Manga.status, value: vm.alManga?.status ?? "-")
            )
            
            MediaAttributes(
                leading: (
                    title: L.Tracker.Manga.averageScore,
                    value: vm.alManga?.averageScore != nil ?
                    "\(vm.alManga?.averageScore ?? 0)%" :
                    vm.alManga?.averageScore.nilToStr ?? "-"
                ),
                trailing: (
                    title: L.Tracker.Manga.country,
                    value: Locale.current.country(forRegionCode: vm.alManga?.countryOfOrigin).uppercased()
                )
            )
            
            MediaAttributes(
                leading: (
                    title: L.Tracker.Manga.source,
                    value: vm.alManga?.source?.replacingOccurrences(of: "_", with: " ") ?? "-"
                ),
                trailing: (title: L.Tracker.Manga.year, value: vm.alManga?.startDate?.year.nilToStr ?? "-")
            )
            
            MediaAttributes(
                leading: (title: L.Tracker.Manga.popularRank, value: vm.getRank(.popular)),
                trailing: (title: L.Tracker.Manga.ratedRank, value: vm.getRank(.rated))
            )
        }
    }
}
