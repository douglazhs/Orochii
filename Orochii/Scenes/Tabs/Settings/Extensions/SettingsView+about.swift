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
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text("Some informations about the app")
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
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
            .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
            
            HStack {
                Text("Build")
                Spacer()
                Text(UIApplication.appBuild ?? "Unknown")
            }
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
            .font(.body)
            .fontWeight(.regular)
            .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
        }
        .standardBars()
        .toolbarRole(.editor)
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Asset.Colors.background.swiftUIColor)
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
        Button("GitHub") {
            do {
                try UIApplication
                    .shared
                    .safariVC(url: AppURLs.gitHub.description)
            } catch let error {
                vm.showAlert = true
                vm.alertInfo = .init(
                    title: String.Common.error,
                    message: error.localizedDescription
                )
            }
        }
        .foregroundStyle(Asset.Colors.button.swiftUIColor)
    }
}
