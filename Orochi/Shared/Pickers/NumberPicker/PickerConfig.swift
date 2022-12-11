//
//  PickerConfig.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 07/12/22.
//

import SwiftUI

struct PickerConfig {
    var title: String = ""
    var values: [Double] = []
    var selection: Binding<Double> = .constant(0)
    var format: String = "%.0f"
    
    mutating func build(for picker: ALPicker) {
        switch picker {
        case .score:
            title = "Score"
            format = "%.1f"
            values = Array(stride(from: 0, through: 10.0, by: 1.0))
        case .chapter:
            title = "Chapter"
            format = "%.0f"
            values = Array(stride(from: 0, through: 1500.0, by: 1.0))
        case .volume:
            title = "Volume"
            format = "%.0f"
            values = Array(stride(from: 0, through: 500.0, by: 1.0))
        }
    }
}
