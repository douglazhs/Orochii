//
//  AniListAccountView+general.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI

extension AniListAccountView {
    /// User bio
    @ViewBuilder
    func bio() -> some View {
        self.item(
            title: "BIO",
            value: vm.user?.about?
                .components(separatedBy: "\n")
                .first?
                .replacingOccurrences(
                    of: "`",
                    with: ""
                )
            ?? "None"
        )
    }
    
    /// Current user activities list
    @ViewBuilder
    func userActivities() -> some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("ACTIVITY")
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
                .unredacted()
            LazyVStack(alignment: vm.isLoading ? .center : .leading, spacing: 10.0) {
                if vm.isLoading {
                    ActivityIndicator()
                } else {
                    if let activities = vm.activities,
                        let _ = activities.first
                    {
                        ForEach(activities) { activity in
                            NavigationLink {
                                MangaActivityView(activity.id)
                            } label: {
                                UserActivityCell(activity: activity)
                            }.foregroundColor(.white)
                        }
                    } else {
                        Text("No activities :(")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}
