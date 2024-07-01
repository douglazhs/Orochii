//
//  RepresentableSheet+modifier.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 13/12/22.
//

import SwiftUI

struct SheetWithDetentsViewModifier<SwiftUIContent>: ViewModifier where SwiftUIContent: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let detents: [UISheetPresentationController.Detent]
    let swiftUIContent: SwiftUIContent
    
    init(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        content: () -> SwiftUIContent,
        detents: [UISheetPresentationController.Detent] = [.medium()]
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.swiftUIContent = content()
        self.detents = detents
    }
    
    func body(content: Content) -> some View {
        ZStack {
            RepresentableSheet(
                $isPresented,
                onDismiss: onDismiss,
                content: { swiftUIContent },
                detents: detents
            ).fixedSize()
            content
        }
    }
}

extension View {
    func representableSheet<Content>(
        isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        content: @escaping () -> Content,
        detents: [UISheetPresentationController.Detent] = [.medium()]
    ) -> some View where Content: View {
        modifier(
            SheetWithDetentsViewModifier(
                isPresented: isPresented,
                onDismiss: onDismiss,
                content: content,
                detents: detents
            )
        )
    }
}
