//
//  CheckboxView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/24.
//

import SwiftUI

struct CheckboxView<T: View>: View {
    var isOn: Bool
    var action: () -> Void
    var label: T
    
    init(isOn: Bool, action: @escaping () -> Void, @ViewBuilder label: @escaping () -> T) {
        self.isOn = isOn
        self.action = action
        self.label = label()
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Label {
                label
            } icon: {
                Image(systemName: isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(isOn ? .accentColor : .secondary)
                    .accessibility(label: Text(isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
    }
}

#Preview {
    CheckboxView(isOn: false) { } label: {
         
    }
}
