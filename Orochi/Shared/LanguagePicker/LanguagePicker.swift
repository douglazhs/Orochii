//
//  LanguagePicker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 26/11/22.
//

import SwiftUI

struct LanguagePicker: View {
    var languages: [Int : String]
    var selectedLang: Binding<Int>
    
    init(
        _ languages: [Int : String],
        selectedLang: Binding<Int>
    ) {
        self.languages = languages
        self.selectedLang = selectedLang
    }
    
    var body: some View {
        Picker(selection: selectedLang){
            ForEach(0..<languages.keys.count, id: \.self) { key in
                Text(languages[key] ?? "")
            }
        } label: { EmptyView() }
    }
}

struct LanguagePicker_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePicker(
            mockLanguages,
            selectedLang: .constant(0)
        )
    }
}
