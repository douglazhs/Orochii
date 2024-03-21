//
//  LanguagesView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

extension LanguagesView {
    @ViewBuilder
    /// Source Languages section
    func languagesSection() -> some View {
        Section {
            ForEach(Language.allCases) { lang in
                Button {
                    if !languages.contains(lang) {
                        languages.append(lang)
                    } else { languages.removeAll(where: { $0 == lang }) }
                } label: {
                    HStack {
                        Text(lang.description)
                        Spacer()
                        if languages.contains(lang) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color("button"))
                                .font(.caption2)
                                .fontWeight(.heavy)
                        } else { EmptyView() }
                    }
                }
                .listSectionSeparator(.hidden)
                .foregroundColor(Color("bodyText"))
            }
        }
    }
}
