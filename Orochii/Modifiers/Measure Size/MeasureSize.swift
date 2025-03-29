//
//  MeasureSize.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 13/12/22.
//

import SwiftUI

public extension View {
    /// Function to perform an action when the Size Preference
    /// changed
    /// - Parameter action: The action to be performed
    /// - Returns: A ViewWith the modifier and the action setted
    func measureSize(perform action: @escaping (CGFloat) -> Void) -> some View {
        modifier(MeasureSizeModifier())
            .onPreferenceChange(
                SizePreferenceKey.self,
                perform: action
            )
    }
}

/// ViewModifier to put a GeometryReader on the background of
/// the View
private struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.overlay(GeometryReader { geometry in
            Color.clear.preference(
                key: SizePreferenceKey.self,
                value: geometry.size.height
            )
        })
    }
}
