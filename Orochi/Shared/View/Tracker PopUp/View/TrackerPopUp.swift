//
//  TrackerPopUp.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 16/02/23.
//

import SwiftUI

/// Entry number type
enum EntryType {
    case keyboard, picker
}

struct TrackerPopUp: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var vm = TrackerPopUpObserver()
    var context: ALPicker
    var total: Double
    var numbers: Array<Double> = Array()
    @Binding var selection: Double
    
    init(
        context: ALPicker,
        total: Double = 10,
        selection: Binding<Double>
    ) {
        self.context = context
        self.numbers = Array(stride(from: 0, to: (total + 1), by: 1))
        self.total = total
        self._selection = selection
    }
    
    var body: some View {
        content()
    }
}

struct TrackerPopUp_Previews: PreviewProvider {
    static var previews: some View {
        TrackerPopUp(
            context: .chapter,
            total: 10,
            selection: .constant(0)
        )
    }
}
