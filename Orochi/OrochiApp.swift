//
//  OrochiiApp.swift
//  Orochi
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

@main
struct OrochiiApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                DiscoverView()
                    .tabItem { Label(
                        String.Discovery.title,
                        systemImage: "globe.americas"
                    ) }
                LibraryView()
                    .tabItem { Label(
                        String.Library.title,
                        systemImage: "books.vertical"
                    ) }
                SettingsView()
                    .tabItem { Label(
                        String.Settings.title,
                        systemImage: "gear"
                    ) }
            }
            .tint(Color(.systemBlue))
            .preferredColorScheme(.dark)
        }
    }
}
