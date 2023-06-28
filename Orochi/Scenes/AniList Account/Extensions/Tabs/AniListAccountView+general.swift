//
//  AniListAccountView+general.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI

extension AniListAccountView {
    /// Current user activities list
    @ViewBuilder
    func userActivities() -> some View {
        LazyVStack(alignment: vm.activities != nil ? .leading : .center, spacing: 7.5) {
            if let activities = vm.activities,
               let last = activities.last {
                ForEach(activities) { activity in
                    NavigationLink {
                        MangaActivityView(activity.id)
                    } label: {
                        UserActivityCell(activity: activity)
                    }.foregroundColor(.white)
                    if activity != last {
                        Divider()
                            .padding(.leading, CGSize.standardImageCell.width * 0.725 + 7.5)
                    }
                }
                .animation(.spring(), value: vm.activities != nil)
            } else {
                if vm.activities == nil {
                    ActivityIndicator()
                } else {
                    Text("No activities :(")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
            }
        }
        .foregroundColor(.white)
    }
}
