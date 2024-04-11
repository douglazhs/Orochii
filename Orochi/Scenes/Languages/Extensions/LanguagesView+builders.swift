//
//  LanguagesView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

extension LanguagesView {
    /// Source Languages section
    @ViewBuilder
    func languagesSection() -> some View {
        Section {
            ForEach(Language.allCases) { lang in
                Button {
                    if !languages.contains(lang) {
                        languages.append(lang)
                    } else {
                        languages.removeAll { $0 == lang }
                    }
                } label: {
                    HStack {
                        Text(lang.description)
                        Spacer()
                        if languages.contains(lang) {
                            Image(systemName: "checkmark")
                                .foregroundColor(Color.ORCH.button)
                                .font(.caption2)
                                .fontWeight(.heavy)
                        } else { EmptyView() }
                    }
                }
                .listSectionSeparator(.hidden)
                .foregroundColor(Color.ORCH.primaryText)
            }
        }
    }
}
