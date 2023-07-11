//
//  TrackerPopUp+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 16/02/23.
//

import SwiftUI

extension TrackerPopUp {
    /// Main **PopUp** content
    @ViewBuilder
    func content() -> some View {
        ZStack {
            Color.black.opacity(0.55)
                .background(BackgroundClearView())
                .edgesIgnoringSafeArea(.all)
            popUp()
        }
    }
    
    /// Built context **PopUp**
    @ViewBuilder
    func popUp() -> some View {
        VStack(alignment: .leading) {
            HStack {
                // BUTTON TO CHOOSE ENTRY TYPE
                if context == .score { entryTypeButton() }
                Spacer()
                // DONE ACTION
                doneAction()
            }
            Divider()
            // ENTRY FIELD
            entryField()
        }
        .padding(.horizontal)
        .background { Color(uiColor: .systemGray6)}
        .cornerRadius(9.0)
        .frame(
            maxWidth: UIScreen.main.bounds.width * 0.85,
            maxHeight: .infinity
        )
    }
    
    /// Entry type field, that can be: `Wheel picker` or `Keyboard`
    @ViewBuilder
    func entryField() -> some View {
        HStack(alignment: .center) {
            // MANGA TITLE
            title()
            // CHOOSEN FIELD(KEYBOARD OR WHEEL PICKER)
            choosenField()
        }
        .padding(
            [.top, .bottom],
            (vm.entryType == .keyboard) ? 22 : .zero
        )
    }
    
    /// Context title, that can be: `Score`, `Volume` or `Chapter`
    @ViewBuilder
    func title() -> some View {
        Text(context.description)
            .foregroundColor(.white.opacity(0.65))
            .fontWeight(.regular)
            .font(.headline)
    }
    
    /// Done button
    @ViewBuilder
    func doneAction() -> some View {
        Button(String.Common.done) {
            dismiss()
        }
        .buttonStyle(.borderless)
        .padding(.top, 24)
        .font(.headline)
        .fontWeight(.semibold)
    }
    
    /// Custom button to change the user's entry type
    @ViewBuilder
    func entryTypeButton() -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.15)) {
                vm.entryType = (vm.entryType == .picker) ? .keyboard : .picker
            }
        } label: {
            Label(
                vm.entryType == .keyboard ? "Wheel" : "Keyboard",
                systemImage: vm.entryType == .keyboard ? "filemenu.and.selection" : "keyboard"
            )
            .foregroundColor(.white.opacity(0.65))
            .fontWeight(.medium)
            .font(.headline)
            .padding(8)
            .background {
                Color(UIColor.systemGray2).opacity(0.265)
                    .cornerRadius(7.5)
            }
        }
        .padding(.top, 24)
    }
    
    /// Choosen entry type
    @ViewBuilder
    func choosenField() -> some View {
        switch vm.entryType {
        case .picker:
            pickerField()
        case .keyboard:
            textField()
        }
    }
    
    /// Keyboard entry type
    @ViewBuilder
    func textField() -> some View {
        TextField("", value: $selection, formatter: vm.textFieldformatter())
            .textFieldStyle(RoundedTextFieldStyle())
            .keyboardType(.decimalPad)
            .font(.system(
                size: 19,
                weight: .regular,
                design: .default)
            )
            .foregroundColor(.white.opacity(0.65))
            .onChange(of: selection) { newValue in
                vm.validateFieldInput(
                    of: newValue,
                    to: $selection
                )
            }
    }

    /// Wheel picker entry type
    @ViewBuilder
    func pickerField() -> some View {
        NumberPicker(
            values: numbers,
            selection: $selection,
            format: "%.0f"
        )
    }
}
