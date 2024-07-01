//
//  ActionPopUp.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 29/11/22.
//

import SwiftUI

struct ActionPopUp: View {
    var title: String?
    var message: String
    @Binding var action: Bool
    
    var body: some View {
        if action {
            Text(message)
                .lineLimit(1)
                .font(.caption)
                .foregroundColor(.accentColor)
                .fontWeight(.bold)
                .padding(7.5)
                .background(Color.ORCH.actionBackground)
                .clipShape(RoundedRectangle(cornerRadius: 7.25))
                .padding(.top, 5.0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.linear(duration: 0.175)) {
                            action = false
                        }
                    }
                }
        }
    }
}

struct ActionPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ActionPopUp(
            title: "Title",
            message: "Action",
            action: .constant(true)
        )
    }
}
