//
//  ALAccountView+stats.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 08/03/24.
//

import Foundation
import SwiftUI
import struct AniListService.UserCountryStatistic

extension ALAccountView {
    /// Authenticated user stats
    @ViewBuilder
    func stats() -> some View {
        List {
            Group {
                staticRows()
                disclosureGroups()
            }
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
            .font(.subheadline)
        }
        .listStyle(.inset)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .background(Asset.Colors.background.swiftUIColor)
    }
    
    @ViewBuilder 
    func staticRows() -> some View {
        Group {
            Text(L.Account.Section.totalMangas)
                .badge(vm.user.statistics?.manga?.count ?? 0)
            Text(L.Account.Section.meanScore)
                .badge(Text(vm.user.statistics?.manga?.meanScore ?? 0, format: .number))
            Text(L.Account.Section.standardDeviation)
                .badge(Text(vm.user.statistics?.manga?.standardDeviation ?? 0, format: .number))
            Text(L.Account.Section.chaptersRead)
                .badge(vm.user.statistics?.manga?.chaptersRead ?? 0)
            Text(L.Account.Section.volumesRead)
                .badge(vm.user.statistics?.manga?.volumesRead ?? 0)
        }
    }
    
    @ViewBuilder 
    func disclosureGroups() -> some View {
        statuses()
        genresAndTags()
        mangasAndChapters()
        countryAndStaff()
    }
    
    @ViewBuilder
    func statuses() -> some View {
        DisclosureGroup(L.Account.Section.statuses, isExpanded: $expandStatus) {
            ForEach(vm.user.statistics?.manga?.statuses ?? [], id: \.status) { stat in
                Text(MangaStatus(rawValue: stat.status ?? "")?.description.uppercased() ?? "")
                    .badge(String(format: "%d", stat.count ?? 0))
            }
        }
    }
    
    @ViewBuilder
    func genresAndTags() -> some View {
        DisclosureGroup(L.Account.Section.genres, isExpanded: $expandGenre) {
            ForEach((vm.user.statistics?.manga?.genres ?? []), id: \.genre) { stat in
                Text(stat.genre ?? "")
                    .badge(stat.count ?? 0)
            }
        }
        DisclosureGroup(L.Account.Section.tags, isExpanded: $expandTag) {
            ForEach(vm.user.statistics?.manga?.tags ?? [], id: \.tag?.id) { stat in
                Text(stat.tag?.name ?? "")
                    .badge(String(format: "%d", stat.count ?? 0))
            }
        }
    }
    
    @ViewBuilder
    func mangasAndChapters() -> some View {
        DisclosureGroup(L.Account.Section.chaptersPerYear, isExpanded: $expandChaptersPerYears) {
            ForEach((vm.user.statistics?.manga?.startYears ?? []), id: \.startYear) { stat in
                Text(String(format: "%d", stat.startYear ?? 0))
                    .badge(stat.chaptersRead ?? 0)
            }
        }
        DisclosureGroup(L.Account.Section.mangasPerYear, isExpanded: $expandCountPerYears) {
            ForEach(vm.user.statistics?.manga?.startYears ?? [], id: \.startYear) { stat in
                Text(String(format: "%d", stat.startYear ?? 0))
                    .badge(String(format: "%d", stat.count ?? 0))
            }
        }
    }
    
    @ViewBuilder
    func countryAndStaff() -> some View {
        DisclosureGroup(L.Account.Section.country, isExpanded: $expandCountry) {
            ForEach(vm.user.statistics?.manga?.countries ?? [], id: \.country) { stat in
                Text(Locale.current.country(forRegionCode: stat.country))
                    .badge(String(format: "%d", stat.count ?? 0))
            }
        }
        DisclosureGroup(L.Account.Section.chaptersPerStaff, isExpanded: $expandStaff) {
            ForEach(vm.user.statistics?.manga?.staff ?? [], id: \.staff?.id) { stat in
                Text(stat.staff?.name?.full ?? L.Common.unknown)
                    .badge(String(format: "%d", stat.chaptersRead ?? 0))
            }
        }
    }
}
