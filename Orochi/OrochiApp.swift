//
//  OrochiiApp.swift
//  Orochi
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

@main
struct OrochiiApp: App {
    enum Tab {
        case discover, library, adjusts
    }
    
    @State var tab: Tab = .discover
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $tab) {
                DiscoverView()
                    .tabItem { Image(systemName: "globe.americas") }
                    .tag(Tab.discover)
                LibraryView()
                    .tabItem { Image(systemName: "books.vertical") }
                    .tag(Tab.library)
                SettingsView()
                    .tabItem { Image(systemName: "gear") }
                    .tag(Tab.adjusts)
            }
            .preferredColorScheme(.dark)
        }
    }
}
