//
//  EnumPicker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

typealias Pickable = CaseIterable
                     & Identifiable
                     & Hashable
                     & CustomStringConvertible

struct EnumPicker<Enum: Pickable, Label: View>: View {
    private let label: Label
    @Binding private var selection: Enum
    
    var body: some View {
        Picker(selection: $selection) {
            ForEach(Array(Enum.allCases)) { value in
                Text(value.description).tag(value)
                    .font(.headline)
            }
        } label: { self.label }
        .tint(Color("title"))
    }
    
    init(selection: Binding<Enum>, label: Label) {
        _selection = selection
        self.label = label
    }
}

extension EnumPicker where Label == Text {

    init(_ titleKey: LocalizedStringKey, selection: Binding<Enum>) {
        label = Text(titleKey)
        _selection = selection
    }

    init<S: StringProtocol>(_ title: S, selection: Binding<Enum>) {
        label = Text(title)
        _selection = selection
    }
}

struct EnumPicker_Previews: PreviewProvider {
    static var previews: some View {
        EnumPicker("Picker", selection: .constant(Language.enUS)
        )
    }
}
