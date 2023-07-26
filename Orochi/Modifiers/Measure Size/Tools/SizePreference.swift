//
//  SizePreference.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 13/12/22.
//

import SwiftUI

/// Height preference key
struct SizePreferenceKeyHeight: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

/// Size preference key
struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) { value = nextValue() }
}
