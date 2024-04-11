//
//  RepresentableSheet.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 13/12/22.
//

import SwiftUI

struct RepresentableSheet<Content>: UIViewRepresentable where Content: View {
    @Binding var isPresented: Bool
    let onDismiss: (() -> Void)?
    let detents: [UISheetPresentationController.Detent]
    let content: Content
    
    init(
        _ isPresented: Binding<Bool>,
        onDismiss: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content,
        detents: [UISheetPresentationController.Detent] = [.medium()]
    ) {
        self._isPresented = isPresented
        self.onDismiss = onDismiss
        self.content = content()
        self.detents = detents
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        let viewController = UIViewController()
        guard let sheetController = viewController.presentationController as? UISheetPresentationController else {
            return
        }
        let hostingController = UIHostingController(rootView: content.measureSize { height in
            sheetController.detents = [.custom { _ in return height }]
        })
        viewController.addChild(hostingController)
        viewController.view.addSubview(hostingController.view)
        configureConstraints(view: hostingController.view, controller: viewController)
        configureSheet(controller: sheetController)
        hostingController.didMove(toParent: viewController)
        viewController.presentationController?.delegate = context.coordinator
        handlePresentation(view: uiView, controller: viewController)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(
            isPresented: $isPresented,
            onDismiss: onDismiss
        )
    }
    
    class Coordinator: NSObject, UISheetPresentationControllerDelegate {
        @Binding var isPresented: Bool
        let onDismiss: (() -> Void)?
        
        init(
            isPresented: Binding<Bool>,
            onDismiss: (() -> Void)? = nil
        ) {
            self._isPresented = isPresented
            self.onDismiss = onDismiss
        }
        
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            isPresented = false
            if let onDismiss = onDismiss {
                onDismiss()
            }
        }
    }
}
