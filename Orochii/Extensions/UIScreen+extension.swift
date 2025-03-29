//
//  UIScreen+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

// UIScreen+extension
extension UIScreen {
    /// Screen width
    public static var width: CGFloat {
        return self.main.bounds.size.width
    }
    
    /// Screen height
    public static var height: CGFloat {
        return self.main.bounds.size.height
    }
}
