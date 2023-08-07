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
        }
        .disabled(vm.occurredAct)
    }
    
    /// Start reading button
    @ViewBuilder
    func startReadingButton() -> some View {
        Button {
            // TODO: Start to read the manga
        } label: {
            Image(systemName: "play.fill")
                .lineLimit(1)
                .font(.footnote)
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity)
                .fontWeight(.heavy)
                .padding(8.5)
        }
        .disabled(vm.occurredAct)
        .foregroundColor(.accentColor)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 7.25))
        .listRowBackground(Color.clear)
    }
    
    /// AniList tracking button
    @ViewBuilder
    func aniListButton() -> some View {
        Button { [weak vm] in
            showAniList = true
            vm?.startAction(for: .aniList)
        } label: {
            Image(systemName: "antenna.radiowaves.left.and.right")
                .foregroundColor(.accentColor)
                .font(.footnote)
                .fontWeight(.heavy)
        }
        .tint(.primary)
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showAniList) {
            ALTracker(
                of: vm.manga,
                cover: vm.api.buildURL(for: .cover(
                    id: vm.manga.id,
                    fileName: vm.imgFileName(of: vm.manga)
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
            } header: {
                Text("Current manga state on library")
            }
            Button(role: .destructive, action: {
                vm.startAction(for: .lib(.remove))
            }) {
                Label(
                    "Remove from library",
                    systemImage: "trash.fill"
                )
            }
            .disabled(!vm.mangaOnLib)
        } label: {
            Image(systemName: vm.mangaOnLib
                  ? "folder.fill.badge.gearshape"
                  : "folder.fill.badge.plus"
            )
            .foregroundColor(vm.mangaOnLib ? .red : Color(.systemBlue))
            .fontWeight(.heavy)
            .font(.footnote)
        }
        .tint(.primary)
        .buttonStyle(.borderedProminent)
    }
}
