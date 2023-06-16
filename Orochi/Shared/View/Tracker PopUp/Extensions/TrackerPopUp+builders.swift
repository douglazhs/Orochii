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
            Color.black.opacity(0.65)
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
                if context == .score { self.entryTypeButton() }
                // TOTAL OF CHAPTERS OR VOLUMES
                if context != .score { self.totalNumber() }
                Spacer()
                // DONE ACTION
                self.doneAction()
            }
            Divider()
            // ENTRY FIELD
            self.entryField()
        }
        .padding(.horizontal)
        .background { BlurBackground(with: backgroundCover) }
        .background { Color(uiColor: .systemGray6)}
        .cornerRadius(9)
        .frame(
            maxWidth: UIScreen.main.bounds.width * 0.85,
            maxHeight: .infinity
        )
    }
    
    /// Total number of chapters or volumes
    @ViewBuilder
    func totalNumber() -> some View {
        Text("Total: _\(numbers.count - 1)_")
            .foregroundColor(.white.opacity(0.65))
            .fontWeight(.regular)
            .font(.headline)
            .padding(.top, 24)
    }
    
    /// Entry type field, that can be: `Wheel picker` or `Keyboard`
    @ViewBuilder
    func entryField() -> some View {
        HStack(alignment: .center) {
            // MANGA TITLE
            self.title()
            // CHOOSEN FIELD(KEYBOARD OR WHEEL PICKER)
            self.choosenField()
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
        .tint(Color(uiColor: .systemIndigo))
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
            self.pickerField()
        case .keyboard:
            self.textField()
        }
    }
    
    /// Keyboard entry type
    @ViewBuilder
    func textField() -> some View {
        HStack {
            TextField("", value: $selection, formatter: vm.textFieldformatter())
                .focused($isFocused)
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
            Button("Ok") {
                isFocused = false
            }
            .buttonStyle(.borderedProminent)
            .tint(Color(uiColor: .systemIndigo))
            .fontWeight(.semibold)
            .font(.headline)
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
