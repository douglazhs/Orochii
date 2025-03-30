//
//  MangaView+editablle.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import SwiftUI

extension MangaView {
    /// Select/Deselect all chapters button
    @ViewBuilder
    func selectChaptersButton() -> some View {
        if vm.isEditingMode {
            Button { [weak vm] in
                vm?.selectAll.toggle()
                vm?.manageSelection($chSelection)
            } label: {
                Text(vm.selectAll ? L.Common.none : L.Common.all)
            }
            .disabled(vm.chapters.isEmpty)
            .tint(!vm.chapters.isEmpty ? Asset.Colors.accentColor.swiftUIColor : Asset.Colors.secondaryText.swiftUIColor)
        }
    }
    
    /// Editable view actions
    @ViewBuilder
    func editButton() -> some View {
        if vm.isEditingMode {
            Button {
                withTransaction(.init(animation: .easeInOut)) {
                    vm.isEditingMode = false
                    vm.showBottomBar = false
                }
            } label: {
                Text(L.Common.done)
                    .fontWeight(.semibold)
            }
        } else {
            actionsMenu()
        }
    }
    
    /// Manga actions
    @ViewBuilder
    func actionsMenu() -> some View {
        Menu {
            Section {
                Button {
                    withTransaction(.init(animation: .easeInOut)) {
                        vm.isEditingMode = true
                        vm.showBottomBar = true
                    }
                } label: {
                    Label(
                        L.Manga.selectChapters,
                        systemImage: "checklist"
                    )
                }
                Button {
                    do {
                        try UIApplication
                            .shared
                            .safariVC(url: "\(AppURLs.mdSite.description)/manga/\(vm.manga.id)")
                    } catch {
                        
                    }
                } label: {
                    Label(L.Manga.Action.viewOnMdex, systemImage: "safari.fill")
                }
            } header: {
                Text(vm.unwrapTitle(of: vm.manga))
            }
            Button(role: .destructive) {
                
            } label: {
                Label(L.Manga.Action.removeDownloads, systemImage: "trash")
            }
           
        } label: {
            Image(systemName: "ellipsis")
        }
    }
    
    /// Chapter actions
    @ViewBuilder
    func chapterActions() -> some View {
        Button { 
            
        } label: {
            Text(L.Action.download)
        }
        .disabled(chSelection.isEmpty)
        Menu {
            Section {
                Button {
                    
                } label: {
                    Label(L.Action.read, systemImage: "eye.fill")
                }
                Button { 
                    
                } label: {
                    Label(L.Action.unread, systemImage: "eye.slash.fill")
                }
            } header: {
                Text("\(chSelection.count) " + L.Manga.selectedChapters.uppercased())
            }
        } label: {
            Text(L.Common.mark)
        }
        .disabled(chSelection.isEmpty)
    }
}
