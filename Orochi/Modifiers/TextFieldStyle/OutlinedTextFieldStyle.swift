//
//  OutlinedTextFieldStyle.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/03/23.
//

import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(7.5)
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 1.5)
            }
    }
}
