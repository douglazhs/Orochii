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
                        "Discover",
                        systemImage: "globe.americas.fill"
                    ) }
                LibraryView()
                    .tabItem { Label(
                        "Library",
                        systemImage: "books.vertical"
                    ) }
                SettingsView()
                    .tabItem { Label(
                        "Settings",
                        systemImage: "gear"
                    ) }
            }
            .tint(.green)
        }
    }
}
