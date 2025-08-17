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
        } footer: {
            Text(L.Adjusts.About.footer)
        }
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
            .font(.body)
            .fontWeight(.regular)
            
            HStack {
                Text(L.Adjusts.About.build)
                Spacer()
                Text(UIApplication.appBuild ?? L.Common.unknown)
            }
            .font(.body)
            .fontWeight(.regular)
        }
        .standardBars(title: L.Adjusts.About.version, inline: true)
        .toolbarRole(.editor)
        .listStyle(.automatic)
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
        .foregroundStyle(.tint)
    }
}
