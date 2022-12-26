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
                        systemImage: "globe.americas.fill"
                    ) }
                LibraryView()
                    .tabItem { Label(
                        String.Library.title,
                        systemImage: "books.vertical"
                    ) }
                HistoryView()
                    .tabItem { Label(
                        "History",
                        systemImage: "clock"
                    ) }
                SettingsView()
                    .tabItem { Label(
                        String.Settings.title,
                        systemImage: "gear"
                    ) }
            }
            .tint(Color.indigo)
            .preferredColorScheme(.dark)
        }
    }
}
