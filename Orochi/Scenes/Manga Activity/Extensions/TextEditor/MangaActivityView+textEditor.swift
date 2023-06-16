//
//  MangaAxtivityView+textEditor.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI

extension MangaActivityView {
    /// Custom text editor
    @ViewBuilder
    func textEditor() -> some View {
        HStack {
            TextField(
                "",
                text: $vm.text,
                prompt: Text(vm.placeholder),
                axis: .vertical
            )
            .onChange(of: vm.text) { _ in
                if vm.text.count >= 2 {
                    vm.canSendReply = true
                } else { vm.canSendReply = false }
            }
            .padding(.horizontal, 12.5)
            .padding(.vertical, 6.5)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(vm.averageColor, lineWidth: 0.35)
            }
            .tint(vm.averageColor)
            .background(vm.averageColor.opacity(0.35))
            .cornerRadius(20)
            .foregroundColor(.white)
            .lineLimit(1...7)
            .font(.subheadline)
            .fontWeight(.regular)
            .multilineTextAlignment(.leading)
            self.sendReply()
        }
        .padding(.horizontal)
        .padding(.vertical, 7.5)
    }
    
    /// Send reply button
    @ViewBuilder
    func sendReply() -> some View {
        Button { vm.sendReply() } label: {
            Image(systemName: "paperplane.circle.fill")
                .font(.title)
                .foregroundColor(vm.averageColor)
        }
        .disabled(!vm.canSendReply)
        .opacity(!vm.canSendReply ? 0.55 : 1.0)
    }
}
