//
//  ReadWdithModifier.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/05/24.
//

import Foundation
import SwiftUI

struct WidthPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

private struct ReadWidthModifier: ViewModifier {
    private var sizeView: some View {
        GeometryReader { geometry in
            Color.clear.preference(key: WidthPreferenceKey.self, value: geometry.size.width)
        }
    }

    func body(content: Content) -> some View {
        content.background(sizeView)
    }
}

extension View {
    func readWidth() -> some View {
        self
            .modifier(ReadWidthModifier())
    }
}
