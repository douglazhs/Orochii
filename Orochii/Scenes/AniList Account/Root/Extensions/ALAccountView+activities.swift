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
        List {
            feedMenu()
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
            
            Section {
                switch vm.activitiesState {
                case .loading: EmptyView()
                case .loaded:
                    if !vm.activities.isEmpty {
                        ForEach(vm.activities) { activity in
                            activityCard(activity)
                                .listRowBackground(Asset.Colors.secondaryBackground.swiftUIColor)
                                .task { [weak vm] in
                                    if vm?.hasReachedEnd(in: activity) ?? false {
                                        vm?.paginateFeed()
                                    }
                                }
                        }
                    } else if vm.activities.isEmpty && !(vm.activitiesState == .loading) {
                        noContent(message: L.Account.noActivities)
                            .listRowBackground(Color.clear)
                    }
                case .failed:
                    noContent(message: L.Account.noActivities)
                        .listRowBackground(Color.clear)
                }
            }
            .listSectionSeparator(.hidden)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(Asset.Colors.background.swiftUIColor)
        .overlay(alignment: .top) {
            // Loading de primeira request/refresh
            if vm.activitiesState == .loading  || vm.favoritesState == .loading {
                IndeterminateProgressView()
            }
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
            .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
            .fontWeight(.medium)
        }
        .menuOrder(.priority)
        .menuStyle(.button)
        .onChange(of: vm.feed) { [weak vm] in
            vm?.changeFeed()
        }
    }
    
    /// Activity card information
    @ViewBuilder
    func activityCard(_ activity: ActivityUnion) -> some View {
        HStack(alignment: .top) {
            userCover(of: activity)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(vm.buildActivity(activity))
                    .font(.caption)
                    .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
                
                HStack(alignment: .center, spacing: 3.5) {
                    Image(systemName: "clock")
                    Text(Date.relativeDate(of: activity.createdAt ?? 0))
                }
                .font(.system(size: 10))
                .fontWeight(.medium)
                .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
            }
            
            Spacer()
            
            mangaCover(of: activity)
        }
        .frame(maxHeight: CGSize.standardImageCell.height * 0.45)
    }
    
    @ViewBuilder
    func userCover(of activity: ActivityUnion) -> some View {
        AsyncImageView(
            url: URL(
                string: activity.user?.avatar?.large
                ?? activity.user?.avatar?.medium
                ?? ""
            ),
            size: CGSize(
                width: CGSize.standardImageCell.width * 0.35,
                height: CGSize.standardImageCell.width * 0.35
            )
        )
        .clipShape(Circle())
    }
    
    @ViewBuilder
    func mangaCover(of activity: ActivityUnion) -> some View {
        MangaStandardImage(
            url: URL(
                string: activity.media?.coverImage?.extraLarge
                ?? activity.media?.coverImage?.large
                ?? activity.media?.coverImage?.medium
                ?? ""
            ),
            size: CGSize(
                width: CGSize.standardImageCell.width * 0.45,
                height: CGSize.standardImageCell.height * 0.45
            ),
            roundCorner: true
        )
    }
}
