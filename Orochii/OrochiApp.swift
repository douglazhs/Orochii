//
//  OrochiiApp.swift
//  Orochi
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

@main
struct OrochiiApp: App {
    enum Tabs: Equatable, Hashable, Identifiable, CaseIterable {
        var id: Self { self }
        
        case discover, library, adjusts
        
        var title: String {
            switch self {
            case .discover: return L.Discovery.title
            case .library: return L.Library.title
            case .adjusts: return L.Adjusts.title
            }
        }
        
        var image: String {
            switch self {
            case .discover: return "globe.americas"
            case .library: return "books.vertical"
            case .adjusts: return "gear"
            }
        }
    }
    
    @State private var selectedTab: Tabs = .discover
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selectedTab) {
                Tab(Tabs.discover.title, systemImage: Tabs.discover.image, value: .discover) {
                    DiscoverView()
                }
                Tab(Tabs.library.title, systemImage: Tabs.library.image, value: .library) {
                    LibraryView()
                }
                Tab(Tabs.adjusts.title, systemImage: Tabs.adjusts.image, value: .adjusts) {
                    SettingsView()
                }
            }
            .preferredColorScheme(.dark)
            .tabViewStyle(.sidebarAdaptable)
        }
    }
}
