//
//  NumberPicker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI

struct NumberPicker: View {
    @Environment(\.dismiss) var dismiss
    var title: String
    var values: [Double]
    var selection: Binding<Double>
    var cover: String
    var format: String = "%.1f"
    
    var body: some View {
        NavigationStack {
            Picker("", selection: selection) {
                ForEach(values, id: \.self) { i in
                    Text(String(format: format, i))
                }
            }
            .pickerStyle(.wheel)
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .background(ViewBackground(with: cover))
            .interactiveDismissDisabled()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button { dismiss() } label: {
                        Text(String.Common.done)
                            .font(.body)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button { dismiss() } label: {
                        Text(String.Common.cancel)
                            .font(.body)
                            .foregroundColor(.primary)
                            .fontWeight(.regular)
                    }
                }
            }
        }
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        NumberPicker(
            title: "Score",
            values: Array(stride(from: 0, through: 10.0, by: 1.0)),
            selection: .constant(0.0),
            cover: "jujutsu",
            format: "%.1f"
        )
    }
}
