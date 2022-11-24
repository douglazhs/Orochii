//
//  StandardCellGradient.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

struct StandardCellGradient: View {
    var body: some View {
        LinearGradient(colors: [Color.primary.opacity(0.075), Color.clear], startPoint: .leading, endPoint: .trailing)
        .cornerRadius(5.5)
    }
}

struct StandardCellGradient_Previews: PreviewProvider {
    static var previews: some View {
        StandardCellGradient()
    }
}
