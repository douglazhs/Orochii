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
    typealias Localized = String.Account
    
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
        }
        .listStyle(.inset)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
        .background(Color.ORCH.background)
    }
    
    @ViewBuilder 
    func staticRows() -> some View {
        Text(Localized.totalMangas)
            .badge(vm.user.statistics?.manga?.count ?? 0)
        Text(Localized.meanScore)
            .badge(Int(vm.user.statistics?.manga?.meanScore ?? 0))
        Text(Localized.chaptersRead)
            .badge(vm.user.statistics?.manga?.chaptersRead ?? 0)
        Text(Localized.volumesRead)
            .badge(vm.user.statistics?.manga?.volumesRead ?? 0)
    }
    
    @ViewBuilder 
    func disclosureGroups() -> some View {
        DisclosureGroup(Localized.statuses, isExpanded: $expandStatus) {
            ForEach(vm.user.statistics?.manga?.statuses ?? [], id: \.status) { stat in
                Text(MangaStatus(rawValue: stat.status ?? "")?.description.uppercased() ?? "")
                    .badge(String(format: "%d", stat.count ?? 0))
            }
        }
        DisclosureGroup(Localized.genres, isExpanded: $expandGenre) {
            ForEach((vm.user.statistics?.manga?.genres ?? []), id: \.genre) { stat in
                Text(stat.genre ?? "")
                    .badge(stat.count ?? 0)
            }
        }
        DisclosureGroup(Localized.tags, isExpanded: $expandTag) {
            ForEach(vm.user.statistics?.manga?.tags ?? [], id: \.tag?.id) { stat in
                Text(stat.tag?.name ?? "")
                    .badge(String(format: "%d", stat.count ?? 0))
            }
        }
        DisclosureGroup(Localized.chaptersPerYear, isExpanded: $expandStartYears) {
            ForEach((vm.user.statistics?.manga?.startYears ?? []), id: \.startYear) { stat in
                Text(String(format: "%d", stat.startYear ?? 0))
                    .badge(stat.chaptersRead ?? 0)
            }
        }
        DisclosureGroup(Localized.country, isExpanded: $expandCountry) {
            ForEach(vm.user.statistics?.manga?.countries ?? [], id: \.country) { stat in
                Text(Locale.current.localizedString(forRegionCode: stat.country ?? "") ?? "")
                    .badge(String(format: "%d", stat.count ?? 0))
            }
        }
    }

}
