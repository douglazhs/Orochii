//
//  ActionPopUp.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 29/11/22.
//

import SwiftUI

struct ActionPopUp: View {
    var message: String
    var action: Binding<Bool>
    
    var body: some View {
        VStack {
            if action.wrappedValue {
                Text(message)
                    .multilineTextAlignment(.center)
                    .font(.caption2)
                    .foregroundColor(.primary.opacity(0.65))
                    .fontWeight(.regular)
            }
        }
        .frame(maxWidth: .infinity)
        .onChange(of: action.wrappedValue) { _ in
            Task {
                try await Task.sleep(
                    until: .now + .seconds(1.0),
                    tolerance: .seconds(1.25),
                    clock: .suspending
                )
                withAnimation(.linear(duration: 0.175)) {
                    self.action.wrappedValue = false
                }
            }
        }
    }
}

struct ActionPopUp_Previews: PreviewProvider {
    static var previews: some View {
        ActionPopUp(
            message: "Action",
            action: .constant(true)
        )
    }
}
