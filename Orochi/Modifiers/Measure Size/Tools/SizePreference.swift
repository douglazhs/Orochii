//
//  SizePreference.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 13/12/22.
//

import SwiftUI

/// Size preference key
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(
        value: inout CGFloat,
        nextValue: () -> CGFloat
    ) { value = nextValue() }
}
