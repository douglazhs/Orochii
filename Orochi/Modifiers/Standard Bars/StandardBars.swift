//
//  StandardBars.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/03/24.
//

import Foundation
import SwiftUI

/// Standard navigation and tab bars
private struct StandardBars: ViewModifier {
    func body (content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .tabBar, .navigationBar, .bottomBar)
            .toolbarBackground(Color.black, for: .navigationBar)
            .toolbarBackground(Color.ORCH.background, for: .tabBar, .bottomBar)
    }
}

public extension View {
    func standardBars() -> some View {
        modifier(StandardBars())
    }
}
