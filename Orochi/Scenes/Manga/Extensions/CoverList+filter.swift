//
//  CoverList+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 04/06/24.
//

import Foundation
import SwiftUI

extension CoverList {
    @ViewBuilder
    func filterBottomView() -> some View {
        NavigationStack {
            List {
                localesSection()
                orderSection()
                    .listSectionSeparator(.hidden, edges: .bottom)
            }
            .listStyle(.grouped)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.never)
            .scrollBounceBehavior(.basedOnSize)
            .background(blurBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Button("Go!") {
                        showFilter = false
                    }
                    .fontWeight(.semibold)
                    .tint(Color.ORCH.button)
                }
            }
        }
    }
    
    @ViewBuilder
    func filterButton() -> some View {
        HStack {
            Spacer()
            Button("", systemImage: "line.3.horizontal.decrease") {
                showFilter = true
                vm.oldCoverFilter = vm.coverFilter
            }
            .disabled(vm.covers.isEmpty)
            .tint(!vm.covers.isEmpty ? Color.ORCH.button : Color.ORCH.secondaryText)
        }
        .padding(.horizontal)
        .padding(.vertical, 5.5)
    }
    
    @ViewBuilder
    func localesSection() -> some View {
        Section {
            ForEach(vm.locales.filter { !$0.isEmpty }, id: \.self) { locale in
                CheckboxView(isOn: vm.coverFilter.locales.contains(locale)) {
                    if !vm.coverFilter.locales.contains(locale) {
                        vm.coverFilter.locales.append(locale)
                    } else {
                        vm.coverFilter.locales.removeAll { $0 == locale }
                    }
                } label: {
                    Text(Locale.current.localizedString(forLanguageCode: locale) ?? locale)
                        .foregroundStyle(Color.ORCH.primaryText)
                        .font(.callout)
                }
            }
        } header: {
            languageSelectionHeader()
        }
        .listRowBackground(Color.clear)
        .foregroundStyle(Color.ORCH.primaryText)
        .listRowBackground(Color.clear)
        .onChange(of: vm.coverFilter.locales) { locales in
            if locales.count == vm.locales.count {
                vm.markAll = true
            } else { vm.markAll = false }
        }
    }
    
    @ViewBuilder
    func languageSelectionHeader() -> some View {
        HStack {
            Text("Language Selection")
            Spacer()
            Button {
                vm.toggleLocaleSelection()
                Haptics.shared.play(.medium)
            } label: {
                Image(
                    systemName: vm.markAll
                    ? "checkmark.square.fill"
                    : "square"
                )
                .imageScale(.large)
            }
            .buttonStyle(.borderless)
            .disabled(vm.locales.isEmpty)
            .foregroundStyle(
                !vm.locales.isEmpty
                ? Color.ORCH.button
                : Color.ORCH.secondaryText
            )
        }
    }
    
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            HStack {
                Text("Volume Order")
                    .foregroundStyle(Color.ORCH.primaryText)
                Spacer()
                Button {
                    vm.coverFilter.volOrder = (vm.coverFilter.volOrder == .asc) ? .desc : .asc
                } label: {
                    HStack {
                        Text("\(vm.coverFilter.volOrder.description)")
                            .foregroundStyle(Color.ORCH.secondaryText)
                        Image(systemName: vm.coverFilter.volOrder == .desc ? "chevron.up" : "chevron.down")
                            .fontWeight(.semibold)
                            .font(.caption)
                    }
                }
                .buttonStyle(.borderless)
            }
            .font(.subheadline)
        } header: {
            Text("Order")
        }
        .listRowBackground(Color.clear)
    }
}
