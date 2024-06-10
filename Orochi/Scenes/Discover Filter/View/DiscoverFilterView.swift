//
//  DiscoverFilterView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 06/06/24.
//

import SwiftUI

struct DiscoverFilterView: View {
    @Environment(\.dismiss)
    var dismiss
    @StateObject var vm: DiscoverFilterViewModel
    
    init() {
        self._vm = StateObject(wrappedValue: DiscoverFilterViewModel())
    }
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    ForEach(vm.categories, id: \.id) { section in
                        DisclosureGroup(section.value) {
                            ForEach(section.children ?? [], id: \.id) { tree in
                                CheckboxView(isOn: false) {
                                    
                                } label: {
                                    Text(Locale.current.localizedString(forLanguageCode: tree.value) ?? tree.value)
                                        .font(.callout)
                                        .foregroundStyle(Color.ORCH.primaryText)
                                }
                                .listRowBackground(Color.clear)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .foregroundStyle(Color.ORCH.primaryText)
                        .font(.callout)
                    }
                }
                .listSectionSeparator(.hidden)
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.never)
            .scrollBounceBehavior(.basedOnSize)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button("Reset") {
                        print("Reset filter!")
                    }
                    .foregroundStyle(Color.ORCH.accentColor)
                    
                    Button("Go!") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.ORCH.button)
                }
            }
        }
    }
}

#Preview {
    DiscoverFilterView()
}
