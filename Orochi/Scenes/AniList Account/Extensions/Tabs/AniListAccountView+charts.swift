//
//  AniListAccountView+charts.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 31/05/23.
//

import SwiftUI
import Charts
import struct AniListService.UserGenreStatistic

extension AniListAccountView {
    /// Genres chart
    @ViewBuilder
    func genresChart() -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("GENRES DISTRIBUTION")
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
                .unredacted()
            if !vm.genresStat.isEmpty {
                Chart {
                    ForEach(vm.genresStat.indices, id: \.self) { i in
                        BarMark(
                            x: .value("Chapters read", vm.genresStat[i].chaptersRead ?? 0),
                            y: .value("Genre", vm.genresStat[i].genre ?? "")
                        )
                        .foregroundStyle(by: .value("Genre", vm.genresStat[i].genre ?? ""))
                        .annotation(position: .trailing) {
                            Text("\(vm.genresStat[i].chaptersRead ?? 0)")
                                .font(.caption2)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .chartYAxis(.hidden)
                .chartYAxisLabel("Genres", position: .leading)
                .chartXAxisLabel("Read chapters", position: .bottom)
                .frame(height: UIScreen.height * 0.3)
            } else { self.noDataToShow() }
        }
    }
    
    /// Start year chart
    @ViewBuilder
    func readChaptersYearChart() -> some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("CHAPTERS READ PER YEAR")
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
                .unredacted()
            if !vm.startYearsStat.isEmpty {
                Chart {
                    ForEach(vm.startYearsStat.indices, id: \.self) { i in
                        LineMark(
                            x: .value("Year", "\(vm.startYearsStat[i].startYear ?? 0)"),
                            y: .value("Chapters read", vm.startYearsStat[i].chaptersRead ?? 0)
                        )
                        PointMark(
                            x: .value("Year", "\(vm.startYearsStat[i].startYear ?? 0)"),
                            y: .value("Chapters read", vm.startYearsStat[i].chaptersRead ?? 0)
                        )
                        .foregroundStyle(by: .value("Year", "\(vm.startYearsStat[i].startYear ?? 0)"))
                        .annotation {
                            Text("\(vm.startYearsStat[i].chaptersRead ?? 0)")
                                .font(.caption2)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .chartYAxis(.hidden)
                .chartXAxisLabel("Year", position: .bottom)
                .chartYAxisLabel("Chapters read", position: .leading)
            } else { self.noDataToShow() }
        }
    }
    
    /// No data to show view
    @ViewBuilder
    func noDataToShow() -> some View {
        Text("No data to show :(")
            .font(.caption)
            .fontWeight(.semibold)
            .unredacted()
    }
}
