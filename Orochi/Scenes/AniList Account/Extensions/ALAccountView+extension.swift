//
//  ALAccountView+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 07/03/24.
//

import Foundation
import SwiftUI

extension ALAccountView {
    @ViewBuilder
    func content() -> some View {
        List {
            tabs().listRowBackground(Color.clear)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Color("background"))
        .fullScreenCover(isPresented: $showWebView) {
            SafariWebView(url: vm.buildWebViewUrl())
                .ignoresSafeArea()
        }
    }
    
    /// User informations separated by tabs
    @ViewBuilder
    func tabs() -> some View {
        Section {
            switch tab {
            case .stats: stats()
            case .activity: activities()
                    .onAppear { vm.getActivities() }
            case .favorites: favorites()
                    .onAppear { vm.getMediListEntry() }
            }
        }.listSectionSeparator(.hidden)
    }
    
    /// Segmented control
    @ViewBuilder
    func picker() -> some View {
        Section {
            Picker("", selection: $tab) {
                ForEach(ALTab.allCases, id: \.self) { tab in
                    Text("\(tab.title)")
                }
            }
            .pickerStyle(.segmented)
        }.listSectionSeparator(.hidden)
    }
    
    /// NavBar trailing buttons
    @ViewBuilder
    func navBarButtons() -> some View {
        Button {
            vm.webView = .profile
            showWebView = true
        } label: {
            Image(systemName: "safari.fill")
                .fontWeight(.semibold)
        }
    }
}
