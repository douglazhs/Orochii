//
//  RepresentableSheet+configutation.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 13/12/22.
//

import SwiftUI

extension RepresentableSheet {
    /// Configure `sheet` constraints
    /// - Parameters:
    ///   - view: `sheet view`
    ///   - controller: Controller that contains the `sheet view`
    func configureConstraints(view: UIView, controller: UIViewController) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftAnchor.constraint(equalTo: controller.view.leftAnchor).isActive = true
        view.topAnchor.constraint(equalTo: controller.view.topAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: controller.view.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor).isActive = true
    }
    
    /// `Sheet` configuration
    /// - Parameter controller: `Sheet` controller that will be cofigurated
    func configureSheet(controller: UISheetPresentationController) {
        controller.prefersEdgeAttachedInCompactHeight = true
        controller.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        controller.prefersGrabberVisible = true
        controller.prefersScrollingExpandsWhenScrolledToEdge = false
        controller.largestUndimmedDetentIdentifier = .medium
    }
    
    /// Handle `sheet` presentation
    /// - Parameters:
    ///   - view: View to present and dismiss current `sheet`
    ///   - controller: View Controller to be presented
    func handlePresentation(view: UIView, controller: UIViewController) {
        if isPresented {
            view.window?.rootViewController?.present(controller, animated: true)
        } else {
            view.window?.rootViewController?.dismiss(animated: true)
        }
    }
}
