//
//  MangaActivityView+replies.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI
import struct AniListService.ActivityReply

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
            if let activity = vm.activity,
               let replies = activity.replies,
               let _ = replies.first
            {
                LazyVStack(alignment: .leading, spacing: 15.0) {
                    ForEach(replies) {
                        self.replyCell($0)
                        if replies.count > 1 {
                            Divider()
                                .padding(
                                    .leading,
                                    (CGSize.standardImageCell.width * 0.65) + 7.5
                                )
                        }
                    }
                }
            } else {
                Text("No replies yet :(")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
        }
    }
    
    /// User reply cell
    @ViewBuilder
    func replyCell(_ reply: ActivityReply) -> some View {
        HStack(alignment: .top, spacing: 7.5) {
            self.userAvatar(url: reply.user?.avatar?.large ?? "")
            VStack(alignment: .leading, spacing: 7.5) {
                self.replyInfo(reply)
                self.userReply(reply)
            }
        }
        .contextMenu {
            Button {
                vm.updateReply(with: reply.id)
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button(role: .destructive) {
                vm.deleteReply(with: reply.id)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    /// User avatar
    @ViewBuilder
    func userAvatar(url: String) -> some View {
        if let url = URL(string: url) {
            AsyncCacheImage(
                url: url,
                placeholder: { ActivityIndicator() }
            ) { image in
                Image(uiImage: image)
                    .resizable()
            }
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
            Text(reply.user?.name ?? "Unknown")
                .font(.subheadline)
                .fontWeight(.semibold)
            Spacer()
            self.likeReplyBtn(isLiked: reply.isLiked ?? false) {
                vm.toggleLike(
                    id: reply.id,
                    type: .activityReply
                )
            }
            self.replyDate(reply.createdAt ?? 0)
        }
    }
    
    /// User reply content
    @ViewBuilder
    func userReply(_ reply: ActivityReply) -> some View {
        Text(reply.text ?? "None")
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
            Text(Date.getDateBy(time: time, format: "MM-dd-yyyy"))
                .font(.caption2)
                .fontWeight(.regular)
            Text("•").font(.caption2)
            Text(Date.getDateBy(time: time, format:  "HH:mm"))
                .font(.caption2)
                .fontWeight(.regular)
        }
        .foregroundColor(Color(uiColor: .systemGray))
    }
}
