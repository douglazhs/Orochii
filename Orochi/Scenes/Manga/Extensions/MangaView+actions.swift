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
            // ADD/REMOVE FROM LIBRARY BUTTON
            self.libraryButton()
        }
        .lineLimit(1)
        .fontWeight(.regular)
        .frame(maxWidth: .infinity)
    }
    
    /// Start reading button
    @ViewBuilder
    func startReadingButton() -> some View {
        Button {
            // TODO: Start to read the manga
        } label: {
            Text(String.Manga.startReading.uppercased())
                .lineLimit(1)
                .foregroundColor(.primary)
                .font(.footnote)
                .frame(maxWidth: .infinity)
        }
        .disabled(vm.action)
        .buttonStyle(.borderedProminent)
    }
    
    /// AniList tracking button
    @ViewBuilder
    func aniListButton() -> some View {
        Button {
            vm.showAniList = true
            vm.btnAction = .aniList
        } label: {
            Text(MangaActions.aniList.description)
                .frame(maxWidth: .infinity)
                .foregroundColor(.primary)
                .font(.footnote)
        }
        .disabled(vm.action)
        .buttonStyle(.borderedProminent)
        .popover(isPresented: $vm.showAniList) {
            AniListTracker(of: manga, action: $vm.action)
        }
    }
    
    @ViewBuilder func libraryButton() -> some View {
        Button(role: vm.mangaOnLib ? .destructive : .none) {
            withAnimation(.linear(duration: 0.175)) {
                vm.action = true
            }
            vm.mangaOnLib.toggle()
            vm.btnAction = (vm.btnAction == .addLib)
            ? .rmvLib
            : .addLib
            if vm.btnAction == .addLib {
                Haptics.shared.notify(.success)
            } else { Haptics.shared.notify(.error) }
        } label: {
            Text(vm.mangaOnLib
                 ? MangaActions.rmvLib.description
                 : MangaActions.addLib.description
            )
            .frame(maxWidth: .infinity)
            .font(.footnote)
        }
        .buttonStyle(.bordered)
        .foregroundColor(vm.mangaOnLib ? .red : .primary)
        .tint(vm.mangaOnLib ? Color.red : Color.primary)
        .disabled(vm.action)
    }
}
