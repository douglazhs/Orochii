//
//  LibraryView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import struct MangaDex.Manga

extension LibraryView {
    @ViewBuilder 
    func content() -> some View {
        if vm.unlocked {
            unlockedContent()
        } else {
            lockedContent()
        }
    }
    
    /// Unlocked content
    @ViewBuilder
    func unlockedContent() -> some View {
        list()
            .standardBars()
            .onChange(of: vm.biometricsState) {
                if $0 == .active { vm.lock() }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    lockButton()
                    filterButton()
                }
                
                ToolbarItem(placement: .principal) {
                    Text(String.Library.title)
                        .font(.title2)
                        .fontWeight(.heavy)
                }
            }
            .searchable(
                text: $vm.query,
                prompt: String.Library.searchPlaceholder
            )
    }
    
    /// Locked content
    @ViewBuilder
    func lockedContent() -> some View {
        VStack(spacing: 15.0) {
            localAuthHandler()
                .onAppear {
                    guard vm.lockClick != nil else {
                        vm.localAuth()
                        return
                    }
                }
        }
        .onChange(of: vm.biometricsState) {
            if $0 == .inactive { vm.unlock() }
        }
        .fontDesign(.rounded)
        .background(BlurBackground(with: .view_background))
    }
    
    /// Local Auth handler
    @ViewBuilder
    func localAuthHandler() -> some View {
        if let error = vm.biometricsError {
            errorHandler(error)
        } else {
            unlockHandler()
        }
    }
    
    /// Local Auth error handler
    @ViewBuilder
    func errorHandler(_ error: Error) -> some View {
        VStack(spacing: 15.0) {
            Spacer()
            
            Text(String.Library.authErrorMessage)
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Text(error.localizedDescription)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .systemRed).opacity(0.75))
            
            Button(String.Library.authRetry) { vm.localAuth() }
                .font(.callout)
                .fontWeight(.heavy)
            
            Spacer()
            
            Image(systemName: vm.unlocked ? "lock.open" : "lock")
                .font(.title2)
                .padding(.bottom)
        }.padding()
    }
    
    /// Unlock button
    @ViewBuilder
    func unlockHandler() -> some View {
        VStack(spacing: 15.0) {
            Spacer()
            
            if let _ = vm.lockClick {
                VStack(spacing: 15.0) {
                    Text(String.Library.authMessage)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Button(String.Library.authUnlock) { vm.localAuth() }
                        .font(.callout)
                        .fontWeight(.heavy)
                }
            }
            
            Spacer()
            
            Image(systemName: vm.unlocked ? "lock.open" : "lock")
                .font(.title2)
                .padding(.bottom)
        }.padding()
    }
    
    /// Manga list
    /// - Returns: Filtered manga list
    @ViewBuilder
    func list() -> some View {
        List(MangaStatus.allCases) { status in
            Section(status.description.uppercased()) {
                ForEach(MangaDomain.samples) {
                    if $0.status == status {
                        cell(of: $0)
                            .listRowInsets(.init(top: 5.5, leading: 0, bottom: 5.5, trailing: 8.5))
                            .listRowSeparator(.hidden)
                            .listSectionSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .contextMenu {
                                // TODO: - Context menu features
                                Button(role: .destructive) { } label: {
                                    Label(String.ContextMenu.rmvFromLib, systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .listRowInsets(.init(top: 11.0, leading: 0, bottom: 4.5, trailing: 0))
        }
        .scrollIndicators(.hidden)
        .refreshable { }
        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
        .background(Color("background"))
        .animation(.spring(), value: [isSearching])
    }
    
    /// Custom manga cell
    /// - Parameter manga: Current manga
    /// - Returns: Custom list cell of current manga
    @ViewBuilder
    func cell(of manga: MangaDomain) -> some View {
        ZStack {
            NavigationLink { /*MangaView(manga)*/ } label: {
                EmptyView()
            }
            .frame(width: 0)
            .opacity(0)
            /*MangaStandardCell(manga)*/
        }
    }
    
    /// Filter button
    /// - Returns: Filter manga results button
    @ViewBuilder
    func filterButton() -> some View {
        Menu {
            LibraryFilterView().environmentObject(vm)
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .fontWeight(.semibold)
        }
        .menuStyle(.borderlessButton)
    }
    
    @ViewBuilder
    /// Lock library button
    /// - Returns: Lock button
    func lockButton() -> some View {
        if vm.biometricsState == .active {
            Button {
                vm.lock()
            } label: {
                Image(systemName: "lock")
                    .fontWeight(.semibold)
            }
        }
    }
}
