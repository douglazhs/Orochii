//
//  RoundedTextFieldStyle.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/03/23.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 4.25)
            .padding(.horizontal, 15)
            .background(
                Color(UIColor.systemGray2).opacity(0.265)
                    .cornerRadius(9)
            )
    }
}
