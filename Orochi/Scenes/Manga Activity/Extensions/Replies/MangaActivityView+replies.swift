//
//  MangaActivityView+replies.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI
import struct AniListService.ActivityReply
import Kingfisher

extension MangaActivityView {
    /// Comments section
    @ViewBuilder
    func replies() -> some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("REPLIES")
                .padding(.bottom, 10.0)
                .font(.caption2)
                .fontWeight(.regular)
                .foregroundColor(Color(uiColor: .systemGray))
                .padding(.horizontal)
            if let activity = vm.activity,
               let replies = activity.replies,
               let last = replies.last
            {
                LazyVStack(alignment: .leading, spacing: 15.0) {
                    ForEach(replies) {
                        replyCell($0)
                        if replies.count > 1 && $0 != last {
                            Divider()
                                .padding(.trailing)
                                .padding(
                                    .leading,
                                    (CGSize.standardImageCell.width * 0.65) + 22
                                )
                        }
                    }
                }
            } else {
                Text("No replies yet :(")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
            }
        }
    }
    
    /// User reply cell
    @ViewBuilder
    func replyCell(_ reply: ActivityReply) -> some View {
        HStack(alignment: .top, spacing: 7.5) {
            if let user = reply.user {
                NavigationLink {
                    AniListAccountView(user.id)
                } label: {
                    self.userAvatar(url: user.avatar?.large ?? "")
                }
                VStack(alignment: .leading, spacing: 7.5) {
                    replyInfo(reply)
                    userReply(reply)
                }
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 5.0)
        .contextMenu {
            if let user = reply.user {
                Button {
                    vm.updateReply(with: reply.id)
                } label: {
                    Label("Edit", systemImage: "pencil")
                }.disabled(!vm.isCurrent(user.id))
                Button(role: .destructive) {
                    vm.deleteReply(with: reply.id)
                } label: {
                    Label("Delete", systemImage: "trash")
                }.disabled(!vm.isCurrent(user.id))
            }
        }
    }
    
    /// User avatar
    @ViewBuilder
    func userAvatar(url: String) -> some View {
        if let url = URL(string: url) {
            KFImage.url(url)
                .fromMemoryCacheOrRefresh()
                .cacheMemoryOnly()
                .memoryCacheExpiration(.seconds(10))
                .fade(duration: 0.375)
                .resizable()
                .frame(
                    width: CGSize.standardImageCell.width * 0.65,
                    height: CGSize.standardImageCell.width * 0.65
                )
                .clipShape(Circle())
        }
    }
    
    /// Reply information
    @ViewBuilder
    func replyInfo(_ reply: ActivityReply) -> some View {
        HStack(alignment: .center) {
            if let user = reply.user {
                Text(vm.isCurrent(user.id)
                     ? "You"
                     : user.name ?? "Unknown"
                )
                .font(.subheadline)
                .fontWeight(.semibold)
            }
            Spacer()
            likeReplyBtn(isLiked: reply.isLiked ?? false) {
                vm.toggleLike(
                    id: reply.id,
                    type: .activityReply
                )
            }
            replyDate(reply.createdAt ?? 0)
        }
    }
    
    /// User reply content
    @ViewBuilder
    func userReply(_ reply: ActivityReply) -> some View {
        let text = reply.text ?? ""
        let string = try? AttributedString(markdown: text)
        
        Text(string ?? "")
            .font(.footnote)
            .fontWeight(.regular)
            .foregroundColor(Color(uiColor: .systemGray))
    }
    
    /// Like reply button
    @ViewBuilder
    func likeReplyBtn(isLiked: Bool, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: isLiked
                  ? "heart.fill"
                  : "heart")
        }
        .buttonStyle(.borderless)
        .font(.footnote)
        .tint(vm.averageColor)
    }
    
    /// Reply date
    @ViewBuilder
    func replyDate(_ time: Int) -> some View {
        HStack(alignment: .top) {
            Text(Date.relativeDate(of: time))
                .font(.caption2)
                .fontWeight(.regular)
            Text("•").font(.caption2)
            Text(Date.getDate(of: time, format:  "HH:mm a"))
                .font(.caption2)
                .fontWeight(.regular)
        }
        .foregroundColor(Color(uiColor: .systemGray))
    }
}
