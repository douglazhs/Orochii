//
//  LanguagePicker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 26/11/22.
//

import SwiftUI

struct LanguagePicker: View {
    var languages: [String]
    var selectedLang: Binding<String>
    
    init(_ languages: [String], selectedLang: Binding<String>) {
        self.languages = languages
        self.selectedLang = selectedLang
    }
    
    var body: some View {
        Picker(selection: selectedLang){
            ForEach(languages, id: \.self) { lang in
                Text(lang.description)
            }
        } label: { EmptyView() }
        .pickerStyle(.menu)
    }
}

struct LanguagePicker_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePicker(
            ["en-US", "pt-BR"],
            selectedLang: .constant("en-US")
        )
    }
}
