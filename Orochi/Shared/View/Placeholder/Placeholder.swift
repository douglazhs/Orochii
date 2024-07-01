//
//  Placeholder.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 14/07/23.
//

import SwiftUI

struct Placeholder: View {
    var overlay: Bool = true
    
    var body: some View {
        RoundedRectangle(cornerRadius: overlay ? 4.5 : 0.0)
            .fill(Color(.systemGray4))
            .overlay {
                if overlay {
                    RoundedRectangle(cornerRadius: 4.5)
                        .stroke(
                            Color(uiColor: .systemGray),
                            lineWidth: 0.35
                        )
                }
            }
    }
}

struct Placeholder_Previews: PreviewProvider {
    static var previews: some View {
        Placeholder()
    }
}
