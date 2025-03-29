//
//  IndeterminateProgressView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/05/24.
//

import Foundation
import SwiftUI

struct IndeterminateProgressView: View {
    @State private var width: CGFloat = 0
    @State private var offset: CGFloat = 0
    @Environment(\.isEnabled) 
    private var isEnabled

    var body: some View {
        Rectangle()
            .foregroundColor(.gray.opacity(0.15))
            .readWidth()
            .overlay(
                Rectangle()
                    .foregroundColor(Asset.Colors.attention.swiftUIColor)
                    .frame(width: self.width * 0.26, height: 3)
                    .clipShape(Capsule())
                    .offset(x: -self.width * 0.6, y: 0)
                    .offset(x: self.width * 1.2 * self.offset, y: 0)
                    .animation(.default.repeatForever().speed(0.245), value: self.offset)
                    .onAppear {
                        withAnimation {
                            self.offset = 1
                        }
                    }
            )
            .opacity(self.isEnabled ? 1 : 0)
            .animation(.default, value: self.isEnabled)
            .frame(height: 3)
            .onPreferenceChange(WidthPreferenceKey.self) { width in
                self.width = width
            }
    }
}

#Preview {
    IndeterminateProgressView()
}
