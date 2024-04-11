//
//  ALAccountView+activities.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 08/03/24.
//

import Foundation
import SwiftUI
import struct AniListService.ActivityUnion

extension ALAccountView {
    @ViewBuilder
    func activities() -> some View {
        switch vm.activitiesState {
        case .loading:
            ActivityIndicator()
                .frame(maxWidth: .infinity)
        case .loaded:
            if !vm.activities.isEmpty {
                ForEach(vm.activities) { activity in
                    Button {
                        vm.selectedActivity = activity.id
                        vm.webView = .activity
                        /*vm.validateURL { result in
                            switch result {
                            case .success(_): showConfirmation = true
                            case .failure: showError = true
                            }
                        }*/
                    } label: {
                        activityCard(activity)
                    }
                }
            } else {
                Text(String.Account.noActivities)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.ORCH.primaryText)
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    /// Activity card information
    @ViewBuilder
    func activityCard(_ activity: ActivityUnion) -> some View {
        HStack(alignment: .top) {
            MangaStandardImage(
                url: URL(string: activity.media?.coverImage?.medium ?? ""),
                size: CGSize(
                    width: CGSize.standardImageCell.width * 0.7,
                    height: CGSize.standardImageCell.height * 0.7
                )
            )
            
            VStack(alignment: .leading) {
                Text(activity.media?.title?.english ?? activity.media?.title?.romaji ?? String.Common.unknown)
                
                Text(vm.buildActivity(activity))
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.ORCH.secondaryText)
                
                Spacer()
                
                Text(Date.getDate(of: activity.createdAt ?? 0, format: "dd-MM-YYYY"))
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundStyle(Color.ORCH.secondaryText)
            }
        }.frame(maxHeight: CGSize.standardImageCell.height * 0.7)
    }
}
