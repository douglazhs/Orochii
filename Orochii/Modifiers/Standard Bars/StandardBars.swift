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
    let title: String?
    let isOpaque: Bool
    
    func body (content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(isOpaque ? .visible : .automatic, for: .tabBar, .navigationBar)
            .toolbarBackground(isOpaque ? Color.black : .clear, for: .navigationBar)
            .toolbarBackground(isOpaque ? Asset.Colors.background.swiftUIColor : .clear, for: .tabBar)
            .toolbar {
                if let title {
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.title2)
                            .fontWeight(.heavy)
                    }
                }
            }
    }
}

public extension View {
    func standardBars(title: String? = nil, isOpaque: Bool = true) -> some View {
        modifier(StandardBars(title: title, isOpaque: isOpaque))
    }
}
