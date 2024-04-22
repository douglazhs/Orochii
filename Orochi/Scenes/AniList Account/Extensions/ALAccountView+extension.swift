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
            tabs()
                .foregroundStyle(Color.ORCH.primaryText)
                .listRowBackground(Color.clear)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(Color.ORCH.background)
        .refreshable { [weak vm] in vm?.refreshTab() }
        .fullScreenCover(isPresented: $showWebView) {
            if let url = vm.validURL {
                SafariWebView(
                    url: url
                ).ignoresSafeArea()
            }
        }
    }
    
    /// User informations separated by tabs
    @ViewBuilder
    func tabs() -> some View {
        switch vm.tab {
        case .stats:
            stats()
                .listSectionSeparator(.hidden)
        case .activity:
            activities()
                .listSectionSeparator(.hidden)
                .onAppear { [weak vm] in vm?.loadFeed() }
        case .favorites:
            favorites()
                .listSectionSeparator(.hidden)
                .onAppear { [weak vm] in vm?.getMediListEntry() }
        }
    }
    
    /// Segmented control
    @ViewBuilder
    func picker() -> some View {
        Section {
            Picker("", selection: $vm.tab) {
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
            vm.validateURL { result in
                switch result {
                case .success(_):
                    vm.webView = .profile
                    showWebView = true
                case .failure:
                    showError = true
                }
            }
        } label: {
            Image(systemName: "safari.fill")
                .fontWeight(.semibold)
        }
    }
    
    /// No content View, when request failed or **favorites** and **activities** is empty
    @ViewBuilder
    func noContent(message: String) -> some View {
        Text(message)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(Color.ORCH.primaryText)
            .frame(maxWidth: .infinity)
    }
}
