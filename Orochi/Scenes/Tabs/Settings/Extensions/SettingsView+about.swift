//
//  SettingsView+about.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/23.
//

import SwiftUI

extension SettingsView {
    /// About app section
    @ViewBuilder
    func aboutApp() -> some View {
        Section {
            NavigationLink {
                appVersion()
            } label: {
                Text("Version")
            }
            gitHub()
        } header: { Text("About") } footer: {
            Text("Some informations about the app")
        }
    }
    
    /// App version and build
    @ViewBuilder
    func appVersion() -> some View {
        List {
            HStack {
                Text("Version")
                Spacer()
                Text(UIApplication.appVersion ?? "Unknown")
            }.listRowBackground(Color.clear)
            HStack {
                Text("Build")
                Spacer()
                Text(UIApplication.appBuild ?? "Unknown")
            }.listRowBackground(Color.clear)
        }
        .navigationTitle("Version")
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)
        .background(BlurBackground(with: .view_background))
    }
    
    /// GitHub repository
    @ViewBuilder
    func gitHub() -> some View {
        Button("GitHub", action: {
            UIApplication.shared
                .safariVC(url: AppURLs.GitHub.description)
        })
    }
}
