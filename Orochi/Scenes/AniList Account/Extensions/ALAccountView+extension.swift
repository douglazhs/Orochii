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
            userDetails().listRowBackground(banner())
            picker().listRowBackground(Color.clear)
            tabs()
                .listRowBackground(Color.clear)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .background(
            BlurBackground(
                with: URL(
                    string: vm.user.bannerImage ?? ""
                ),
                radius: Constants.device == .phone ? 8.5 : 15
            )
        )
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
                .font(.footnote)
                .fontWeight(.heavy)
        }
        .tint(.white.opacity(0.75))
        .clipShape(Circle())
        .buttonStyle(.bordered)
        
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.footnote)
                .fontWeight(.heavy)
        }
        .tint(.white.opacity(0.75))
        .clipShape(Circle())
        .buttonStyle(.bordered)
    }
}
