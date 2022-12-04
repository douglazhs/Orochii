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
        VStack(alignment: .center) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
            if action.wrappedValue {
                Text(message)
                    .lineLimit(1)
                    .multilineTextAlignment(.center)
                    .font(.caption2)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.primary.opacity(0.65))
                    .fontWeight(.regular)
            }
        }
        .frame(maxWidth: frame(of: title, and: message))
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
            title: "Title",
            message: "Action",
            action: .constant(true)
        )
    }
}
