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
            aniListButton()
            // ADD/REMOVE BUTTON
            libraryButton()
            Spacer()
        }
        .disabled(vm.occurredAct)
    }
    
    /// Start reading button
    @ViewBuilder
    func startReadingButton() -> some View {
        Button {
            // TODO: Start to read the manga
        } label: {
            HStack {
                Image(systemName: "play")
                    .foregroundColor(Color.ORCH.button)
                // TODO: Change to current manga reading status
                Text("CH. 1")
                    .foregroundStyle(.white)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: CGSize.dynamicImage.width)
            .fontWeight(.heavy)
            .font(.footnote)
            .lineLimit(1)
        }
        .disabled(vm.occurredAct)
        .tint(Color.ORCH.actionBackground)
        .buttonStyle(.borderedProminent)
    }
    
    /// AniList tracking button
    @ViewBuilder
    func aniListButton() -> some View {
        Button { [weak vm] in
            showAniList = true
            vm?.startAction(for: .aniList)
        } label: {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .foregroundColor(Color.ORCH.button)
                .font(.footnote)
                .fontWeight(.heavy)
        }
        .tint(Color.ORCH.actionBackground)
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showAniList) {
            ALTracker(
                of: vm.manga,
                cover: vm.api.buildURL(for: .cover(
                    id: vm.manga.id,
                    fileName: vm.imgFileName(
                        of: vm.manga,
                        quality: vm.coverQuality.key
                    )
                )),
                action: $vm.occurredAct
            )
            .presentationDetents([.medium, .large])
            .interactiveDismissDisabled()
            .presentationDragIndicator(.hidden)
        }
    }
    
    /// Add/Remove from library button
    @ViewBuilder
    func libraryButton() -> some View {
        Menu {
            Section {
                statusPicker()
            } header: {
                Text("Current manga state on library")
            }
            
            rmvFromLibBtn().disabled(!vm.mangaOnLib)
        } label: {
            Image(systemName: vm.mangaOnLib
                ? "folder.fill.badge.gearshape"
                : "folder.fill.badge.plus"
            )
            .foregroundColor(vm.mangaOnLib ? Color.ORCH.attention : Color.ORCH.accentColor)
            .fontWeight(.heavy)
            .font(.footnote)
        }
        .tint(Color.ORCH.actionBackground)
        .buttonStyle(.borderedProminent)
    }
    
    /// Manga status picker
    @ViewBuilder
    func statusPicker() -> some View {
        Picker(selection: $vm.libStatus) {
            ForEach(MangaStatus.allCases) {
                if $0 != .none { Label($0.description, systemImage: $0.icon) }
            }
        } label: {
            if vm.libStatus != .none {
                Label(
                    vm.libStatus.description,
                    systemImage: vm.libStatus.icon
                )
            } else { Text(vm.libStatus.description) }
        }
        .pickerStyle(.menu)
        .onChange(of: vm.libStatus) {
            if $0 != .none {
                vm.startAction(for: .lib(.changeFolder))
            }
        }
    }
    
    /// Remove from library button
    @ViewBuilder
    func rmvFromLibBtn() -> some View {
        Button(role: .destructive) {
            vm.startAction(for: .lib(.remove))
        } label: {
            Label(
                "Remove from library",
                systemImage: "trash.fill"
            )
        }
    }
}
