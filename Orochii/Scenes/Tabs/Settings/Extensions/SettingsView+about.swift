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
                Text(L.Adjusts.About.version)
            }
            gitHub()
        } header: {
            Text(L.Adjusts.About.header)
                .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
        } footer: {
            Text(L.Adjusts.About.footer)
                .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
        }
        .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
    }
    
    /// App version and build
    @ViewBuilder
    func appVersion() -> some View {
        List {
            HStack {
                Text(L.Adjusts.About.version)
                Spacer()
                Text(UIApplication.appVersion ?? L.Common.unknown)
            }
            .listRowBackground(Color.clear)
            .listSectionSeparator(.hidden)
            .font(.body)
            .fontWeight(.regular)
            .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
            
            HStack {
                Text(L.Adjusts.About.build)
                Spacer()
                Text(UIApplication.appBuild ?? L.Common.unknown)
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
                Text(L.Adjusts.About.version)
                    .font(.title2)
                    .fontWeight(.heavy)
            }
        }
    }
    
    /// GitHub repository
    @ViewBuilder
    func gitHub() -> some View {
        Button(String.Name.gitHub) {
            do {
                try UIApplication
                    .shared
                    .safariVC(url: AppURLs.gitHub.description)
            } catch let error {
                vm.showAlert = true
                vm.alertInfo = .init(
                    title: L.Common.error,
                    message: error.localizedDescription
                )
            }
        }
        .foregroundStyle(Asset.Colors.button.swiftUIColor)
    }
}
