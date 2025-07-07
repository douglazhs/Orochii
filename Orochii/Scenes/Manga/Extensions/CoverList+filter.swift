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
                    Button(L.Filter.action) {
                        showFilter = false
                    }
                    .fontWeight(.semibold)
                    .tint(Asset.Colors.button.swiftUIColor)
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
            .tint(!vm.covers.isEmpty ? Asset.Colors.button.swiftUIColor : Asset.Colors.secondaryText.swiftUIColor)
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
                    Text(Locale.current.country(forLanguageCode: locale).capitalized)
                        .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
                        .font(.callout)
                }
            }
        } header: {
            languageSelectionHeader()
        }
        .listRowBackground(Color.clear)
        .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
        .listRowBackground(Color.clear)
        .onChange(of: vm.coverFilter.locales) { _, newLocales in
            if newLocales.count == vm.locales.count {
                vm.markAll = true
            } else { vm.markAll = false }
        }
    }
    
    @ViewBuilder
    func languageSelectionHeader() -> some View {
        HStack {
            Text(L.Manga.Covers.Filter.languages)
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
                ? Asset.Colors.button.swiftUIColor
                : Asset.Colors.secondaryText.swiftUIColor
            )
        }
    }
    
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            HStack {
                Text(L.Manga.Covers.Filter.volume)
                    .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
                Spacer()
                Button {
                    vm.coverFilter.volOrder = (vm.coverFilter.volOrder == .asc) ? .desc : .asc
                } label: {
                    HStack {
                        Text("\(vm.coverFilter.volOrder.description)")
                            .foregroundStyle(Asset.Colors.secondaryText.swiftUIColor)
                        Image(systemName: vm.coverFilter.volOrder == .desc ? "chevron.up" : "chevron.down")
                            .fontWeight(.semibold)
                            .font(.caption)
                    }
                }
                .buttonStyle(.borderless)
            }
            .font(.subheadline)
        } header: {
            Text(L.order)
        }
        .listRowBackground(Color.clear)
    }
}
