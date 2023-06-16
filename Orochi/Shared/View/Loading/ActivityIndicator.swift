//
//  ActivityIndicator.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

struct ActivityIndicator: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
