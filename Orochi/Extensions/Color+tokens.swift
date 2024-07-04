//
//  Color+tokens.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/03/24.
//

import SwiftUI

/// Color+tokens
public extension Color {
    /// Orochi exclusive colors
    enum ORCH {
        static let accentColor: Color = { Color("AccentColor") }()
        static let button: Color = { Color("button") }()
        static let primaryText: Color = { Color("primaryText") }()
        static let secondaryText: Color = { Color("secondaryText") }()
        static let secondaryTitle: Color = { Color("secondaryTitle") }()
        static let attention: Color = { Color("attention") }()
        static let background: Color = { Color("background") }()
        static let secondaryBackground: Color = { Color("secondaryBackground") }()
        static let actionBackground: Color = { Color("actionBackground") }()
        static let selectedSegment: Color = { Color("selectedSegment") }()
    }
}
