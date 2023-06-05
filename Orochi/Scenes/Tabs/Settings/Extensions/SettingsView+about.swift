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
            ForEach(AboutPage.allCases) { page in
                NavigationLink {
                    self.aboutDestination(page)
                } label: {
                    Text(page.description)
                }
            }
            self.gitHub()
        } header: { Text("About") } footer: {
            Text("Some informations about the app")
        }
    }
    
    /// About page destination
    @ViewBuilder
    func aboutDestination(_ page: AboutPage) -> some View {
        switch page {
        case .about:   self.aboutText()
        case .version: self.appVersion()
        }
    }
    
    /// App about text
    @ViewBuilder
    func aboutText() -> some View {
        ScrollView(showsIndicators: false) {
            Text("Orochi is an open source application for reading and tracking manga, written natively in the iOS ecosystem, in the Swift language. \n\nThe app uses the MangaDex website as a source for reading and researching manga. \n\nFor tracking, the AniList website is used.")
                .font(.footnote)
                .fontWeight(.regular)
                .padding()
        }
        .navigationTitle("About")
        .background(BlurBackground(with: .view_background))
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
