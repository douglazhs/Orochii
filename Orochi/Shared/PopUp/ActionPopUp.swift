//
//  ActionPopUp.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 29/11/22.
//

import SwiftUI

struct ActionPopUp: View {
    var title: String
    var message: String
    var action: Binding<Bool>
    
    var body: some View {
        VStack(alignment: .center, spacing: 1.5) {
            HStack {
                Text(title)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .lineLimit(1)
            }
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
                    until: .now + .seconds(2.25),
                    tolerance: .seconds(2),
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
            title: "Title",
            message: "Action",
            action: .constant(true)
        )
    }
}
