//
//  AniListAccountView+stats.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI

extension AniListAccountView {
    /// Main stats
    @ViewBuilder
    func stats() -> some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                item(
                    title: "TOTAL MANGAS",
                    value: "\(vm.user?.statistics?.manga?.count ?? 0)"
                )
                Spacer()
                item(
                    title: "VOLUMES READ",
                    value: "\(vm.user?.statistics?.manga?.volumesRead ?? 0)"
                )
            }.padding(.leading, 10.0)
            
            Spacer()
            
            VStack(alignment: .leading) {
                item(
                    title: "CHAPTERS READ",
                    value: "\(vm.user?.statistics?.manga?.chaptersRead ?? 0)"
                )
                Spacer()
                item(
                    title: "MEAN SCORE",
                    value: String(
                        format: "%.2f",
                        (vm.user?.statistics?.manga?.meanScore ?? 0) / 10
                    )
                )
            }
        }
    }
    
    /// Stat item
    @ViewBuilder
    func item(title: String, value: String) -> some View{
        VStack(alignment: .leading, spacing: 4.0) {
            Text(title)
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
            Text(value)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
}
