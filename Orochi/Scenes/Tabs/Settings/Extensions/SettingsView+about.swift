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
        } header: {
            Text("About")
        } footer: {
            Text("Some informations about the app")
                .foregroundStyle(Color("secondaryText"))
        }
        .foregroundColor(Color("bodyText"))
    }
    
    /// App version and build
    @ViewBuilder
    func appVersion() -> some View {
        List {
            HStack {
                Text("Version")
                Spacer()
                Text(UIApplication.appVersion ?? "Unknown")
            }
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
            .font(.body)
            .fontWeight(.regular)
            .foregroundStyle(Color("bodyText"))
            
            HStack {
                Text("Build")
                Spacer()
                Text(UIApplication.appBuild ?? "Unknown")
            }
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
            .font(.body)
            .fontWeight(.regular)
            .foregroundStyle(Color("bodyText"))
        }
        .standardBars()
        .toolbarRole(.editor)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color("background"))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Version")
                    .font(.title2)
                    .fontWeight(.heavy)
            }
        }
    }
    
    /// GitHub repository
    @ViewBuilder
    func gitHub() -> some View {
        Button("GitHub", action: {
            UIApplication.shared
                .safariVC(url: AppURLs.GitHub.description)
        })
        .foregroundStyle(Color("button"))
    }
}
