//
//  Placeholder.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 14/07/23.
//

import SwiftUI

struct Placeholder: View {
    var body: some View {
            RoundedRectangle(cornerRadius: 4.5)
                .fill(Color(.systemGray5))
                .overlay(
                    RoundedRectangle(cornerRadius: 4.5)
                        .stroke(
                            Color(uiColor: .systemGray4),
                            lineWidth: 0.75
                        )
                )
    }
}

struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder()
    }
}
