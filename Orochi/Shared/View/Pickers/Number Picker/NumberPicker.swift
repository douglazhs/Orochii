//
//  NumberPicker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 28/11/22.
//

import SwiftUI

struct NumberPicker: View {
    @Environment(\.dismiss) var dismiss
    var values: [Double]
    var selection: Binding<Double>
    var format: String = "%.1f"
    
    var body: some View {
        Picker("", selection: selection) {
            ForEach(values, id: \.self) { i in
                Text(String(format: format, i))
            }
        }.pickerStyle(.inline)
    }
}

struct NumberPicker_Previews: PreviewProvider {
    static var previews: some View {
        NumberPicker(
            values: Array(stride(from: 0, through: 10.0, by: 1.0)),
            selection: .constant(0.0),
            format: "%.1f"
        )
    }
}
