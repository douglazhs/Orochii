//
//  LoadingView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 10) {
            ActivityIndicator()
            Text("LOADING")
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
