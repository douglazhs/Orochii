//
//  PickerTextField.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/08/23.
//

import SwiftUI

struct PickerTextField: UIViewRepresentable {
    var data: [Double]
    var dataFormat: String
    var placeholder: String
    var field: ALPicker
    let helper: Helper = Helper()
    @Binding var selection: Double?
    
    func makeUIView(context: Context) -> UITextField {
        let pickerView = buildPicker(in: context)
        let textField = buildTextField()
        
        let toolbar = UIToolbar(frame: CGRect(
            x: 0.0,
            y: 0.0,
            width: UIScreen.width,
            height: 44.0
        ))
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        let flexible = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: String.Common.done,
            style: .done,
            target: helper,
            action: #selector(helper.doneButtonAction)
        )
        toolbar.setItems([flexible, doneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerView
        
        helper.doneButtonTapped = { textField.resignFirstResponder() }
        
        return textField
    }
    
    func buildTextField() -> UITextField {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        
        textField.textAlignment = .center
        textField.backgroundColor = UIColor(named: "tabBar")
        textField.textColor = .clear
        textField.tintColor = .clear
        textField.layer.cornerRadius = 4.25
        textField.borderStyle = .none
        
        return textField
    }
    
    func buildPicker(in context: Context) -> UIPickerView {
        let pickerView = UIPickerView()
        
        pickerView.delegate = context.coordinator
        pickerView.dataSource = context.coordinator
        pickerView.selectRow(
            field == .score ? Int(selection ?? 0) * 10 : Int(selection ?? 0),
            inComponent: 0,
            animated: true
        )
        
        return pickerView
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = String(format: dataFormat, selection ?? 0)
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(data: self.data, dataFormat: self.dataFormat) { index in
            self.selection = self.data[index]
        }
    }
    
    class Helper {
        public var doneButtonTapped: (() -> Void)?
        
        @objc 
        func doneButtonAction() {
            doneButtonTapped?()
        }
    }
    
    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
        private var data: [Double]
        private var dataFormat: String
        private var didSelectItem: ((Int) -> Void)?
        
        init(data: [Double], dataFormat: String, didSelectItem: ((Int) -> Void)? = nil) {
            self.data = data
            self.dataFormat = dataFormat
            self.didSelectItem = didSelectItem
        }
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.data.count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(format: dataFormat, self.data[row])
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            didSelectItem?(row)
        }
    }
}

struct PickerTextField_Previews: PreviewProvider {
    static var previews: some View {
        PickerTextField(
            data: Array(stride(from: 0, through: 10, by: 1)),
            dataFormat: "%.0f",
            placeholder: "",
            field: .score,
            selection: .constant(0)
        )
    }
}
