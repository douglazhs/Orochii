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
        HStack(alignment: .center, spacing: 3.5) {
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
            }.font(.title3)
            
            Text("\(vm.activity?.likeCount ?? 0) likes")
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(vm.averageColor)
            
            Spacer()
        }
        .padding(.vertical, vm.activity?.likeCount != 0 ? 10.0 : 0)
        .padding(.top, vm.activity?.likeCount == 0 ? 10.0 : 0)
        .buttonStyle(.borderless)
        .tint(vm.averageColor)
    }
}
