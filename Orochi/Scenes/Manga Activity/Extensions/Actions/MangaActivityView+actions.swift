//
//  MangaActivityView+actions.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 03/06/23.
//

import SwiftUI

extension MangaActivityView {
    typealias Action = () -> Void
    
    /// Like actions
    @ViewBuilder
    func actions() -> some View {
        HStack(alignment: .center, spacing: 7.5) {
            Button {
                vm.toggleLike(
                    id: vm.activity?.id ?? 0,
                    type: .activity
                )
            } label: {
                Image(systemName: (vm.activity?.isLiked ?? false)
                      ? "heart.fill"
                      : "heart"
                )
            }
            .font(.title3)
            
            Button("\(vm.activity?.likeCount ?? 0) Likes") {
                showLikes = true
            }
            .buttonStyle(.borderless)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(vm.averageColor)
            .popover(isPresented: $showLikes) {
                if let activity = vm.activity,
                   let likes = activity.likes {
                    List(likes) {
                        Text($0.name ?? "Unknown")
                    }
                    .frame(
                        width: UIScreen.width / 2,
                        height: UIScreen.height / 2
                    )
                }
                
            }
            Spacer()
        }
        .padding(.vertical, 10.0)
        .buttonStyle(.borderless)
        .tint(vm.averageColor)
    }
}
