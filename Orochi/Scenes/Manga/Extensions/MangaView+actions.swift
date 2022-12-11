//
//  MangaView+actions.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension MangaView {
    /// Buttons actions
    @ViewBuilder
    func actions() -> some View {
        HStack {
            // ANILIST BUTTON
            self.aniListButton()
            // ADD/REMOVE BUTTON
            self.libraryButton()
        }
        .lineLimit(1)
        .fontWeight(.regular)
    }
    
    /// Start reading button
    @ViewBuilder
    func startReadingButton() -> some View {
        Button {
            // TODO: Start to read the manga
        } label: {
            Label("START", systemImage: "play.fill")
                .lineLimit(1)
                .foregroundColor(.accentColor)
                .font(.footnote)
                .frame(maxWidth: CGSize.dynamicImage.width - 22)
                .fontWeight(.heavy)
        }
        .tint(.primary)
        .buttonStyle(.borderedProminent)
    }
    
    /// AniList tracking button
    @ViewBuilder
    func aniListButton() -> some View {
        Button { vm.startAction(for: .aniList) } label: {
            Image(systemName: "externaldrive.fill")
                .foregroundColor(.primary)
                .font(.footnote)
                .fontWeight(.semibold)
        }
        .disabled(vm.occurredAct)
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $vm.showAniList) {
            ALTracker(
                of: manga,
                action: $vm.occurredAct
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
    
    /// Add/Remove from library button
    @ViewBuilder
    func libraryButton() -> some View {
        Button(role: vm.mangaOnLib ? .destructive : .none) {
            vm.startAction(for: .lib)
        } label: {
            Image(systemName: vm.mangaOnLib
                  ? "trash.fill"
                  : "plus"
            )
        }
        .font(.footnote)
        .fontWeight(.heavy)
        .tint(.primary)
        .foregroundColor(vm.mangaOnLib ? .red : .accentColor)
        .buttonStyle(.borderedProminent)
        .disabled(vm.occurredAct)
    }
    
    /// Chapters history button
    @ViewBuilder
    func historyButton() -> some View {
        Menu {
            Button {
                vm.startAction(for: .history(clear: false))
            } label: {
                Label("View", systemImage: "eye.fill")
            }
            Button(role: .destructive) {
                vm.startAction(for: .history(clear: true))
            } label: {
                Label("Clear", systemImage: "trash")
            }
        } label: {
           Image(systemName: "clock.arrow.circlepath")
                .foregroundColor(.primary)
                .font(.footnote)
        }
        .buttonStyle(.borderedProminent)
        .disabled(vm.occurredAct)
        .sheet(isPresented: $vm.showHistory) {
            MangaHistoryView(
                of: manga,
                action: $vm.occurredAct
            )
            .presentationDetents([.medium, .large])
        }
    }
}
