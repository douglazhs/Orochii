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
    let inline: Bool
    
    
    func body (content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(inline ? .inline : .large)
            .navigationTitle(title ?? "")
    }
}

public extension View {
    func standardBars(title: String? = nil, inline: Bool = false) -> some View {
        modifier(StandardBars(title: title, inline: inline))
    }
}
