//
//  LibraryView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import MangaDex

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
            .standardBars(isOpaque: Constants.device == .pad ? false : true)
            .onChange(of: vm.biometricsState) { _, newValue in
                if newValue == .active { vm.lock() }
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    lockButton()
                    filterButton()
                }
            }
            .searchable(
                text: $vm.query,
                prompt: L.Library.Search.placeholder
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
        .onChange(of: vm.biometricsState) { _, newValue in
            if newValue == .inactive { vm.unlock() }
        }
        .fontDesign(.rounded)
        .background(BlurBackground(with: Asset.Assets.viewBackground.swiftUIImage))
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
            
            Text(L.Library.Auth.errorMessage)
                .font(.callout)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            
            Text(error.localizedDescription)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(Color(uiColor: .systemRed).opacity(0.75))
            
            Button(L.Library.Auth.retry) { vm.localAuth() }
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
            
            if vm.lockClick != nil {
                VStack(spacing: 15.0) {
                    Text(L.Library.Auth.message)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                    Button(L.Library.Auth.unlock) { vm.localAuth() }
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
                ForEach([MangaMock.manga]) { manga in
                    if (MangaStatus(rawValue: manga.attributes?.status ?? "") ?? MangaStatus.none) == status {
                        cell(of: manga)
                            .listRowInsets(.init(top: 5.5, leading: 0, bottom: 5.5, trailing: 8.5))
                            .listRowSeparator(.hidden)
                            .listSectionSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .contextMenu {
                                // TODO: - Context menu features
                                Button(role: .destructive) { } label: {
                                    Label(L.Action.removeFromLibrary, systemImage: "trash")
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
        .background(Asset.Colors.background.swiftUIColor)
        .animation(.spring(), value: [isSearching])
    }
    
    /// Custom manga cell
    /// - Parameter manga: Current manga
    /// - Returns: Custom list cell of current manga
    @ViewBuilder
    func cell(of manga: Manga) -> some View {
        ZStack {
            NavigationLink {
                MangaView(manga)
            } label: {
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
    
    
    /// Lock library button
    /// - Returns: Lock button
    @ViewBuilder
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
