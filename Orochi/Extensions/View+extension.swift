//
//  View+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/07/23.
//

import SwiftUI

// View+extension
extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKeyHeight.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKeyHeight.self, perform: onChange)
    }
}
