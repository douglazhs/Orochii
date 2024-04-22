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
        feedMenu()
            .listSectionSeparator(.hidden)
        
        switch vm.activitiesState {
        case .loading:
            ActivityIndicator()
                .frame(maxWidth: .infinity)
        case .loaded:
            if !vm.activities.isEmpty {
                ForEach(vm.activities) { activity in
                    activityCard(activity)
                        .listRowBackground(Color.ORCH.secondaryBackground)
                        .task { [weak vm] in
                            if vm?.hasReachedEnd(in: activity) ?? false {
                                vm?.paginateActivities()
                            }
                        }
                }
            } else {
                noContent(message: String.Account.noActivities)
            }
        case .failed:
            noContent(message: String.Account.noActivities)
        }
    }
    
    /// Feed menu selection
    @ViewBuilder
    func feedMenu() -> some View {
        Menu {
            Picker("", selection: $vm.feed) {
                ForEach(Feed.allCases) {
                    Label(
                        $0.description,
                        systemImage: $0.icon
                    )
                }
            }
        } label: {
            HStack {
                Text(vm.feed.description)
                    .font(.subheadline)
                Image(systemName: "chevron.down")
                    .font(.footnote)
            }
            .foregroundStyle(Color.ORCH.primaryText)
            .fontWeight(.medium)
        }
        .menuOrder(.priority)
        .menuStyle(.button)
        .onChange(of: vm.feed) { [weak vm] _ in
            vm?.changeFeed()
        }
    }
    
    /// Activity card information
    @ViewBuilder
    func activityCard(_ activity: ActivityUnion) -> some View {
        HStack(alignment: .top) {
            MangaStandardImage(
                url: URL(string: activity.media?.coverImage?.medium ?? ""),
                size: CGSize(
                    width: CGSize.standardImageCell.width * 0.65,
                    height: CGSize.standardImageCell.height * 0.65
                )
            )
            
            HStack(alignment: .top) {
                Text(vm.buildActivity(activity))
                    .font(.caption)
                    .foregroundStyle(Color.ORCH.primaryText)
                
                Spacer()
                
                Text(Date.relativeDate(of: activity.createdAt ?? 0))
                    .font(.system(size: 10))
                    .foregroundStyle(Color.ORCH.primaryText)
            }
        }
        .frame(maxHeight: CGSize.standardImageCell.height * 0.7)
    }
}