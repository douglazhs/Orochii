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
            .fill(Color(.systemGray))
            .frame(
                maxWidth: CGSize.standardImageCell.width,
                maxHeight: CGSize.standardImageCell.height
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4.5)
                    .stroke(
                        Color(uiColor: .systemGray),
                        lineWidth: 1.05
                    )
            )
    }
}

struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder()
    }
}
