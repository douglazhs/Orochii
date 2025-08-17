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
                filterActions()
            }
            .standardBars(title: L.Filter.action, inline: true)
            .toolbarRole(.editor)
            .scrollIndicators(.never)
            .scrollBounceBehavior(.basedOnSize)
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
            .tint(!vm.covers.isEmpty ? Color.accentColor : .secondary)
            .buttonBorderShape(.circle)
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
        .padding(.horizontal)
        .padding(.top, 10.0)
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
                        .foregroundStyle(.primary)
                }
            }
        } header: {
            languageSelectionHeader()
        }
        .foregroundStyle(.primary)
        .onChange(of: vm.coverFilter.locales) { _, newLocales in
            if newLocales.count == vm.locales.count {
                vm.markAll = true
            } else { vm.markAll = false }
        }
    }
    
    @ViewBuilder
    func languageSelectionHeader() -> some View {
        HStack {
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
            .controlSize(.large)
            .disabled(vm.locales.isEmpty)
            .foregroundStyle(
                !vm.locales.isEmpty
                ? Color.accentColor
                : .secondary
            )
        }
    }
    
    @ViewBuilder
    func orderSection() -> some View {
        Section {
            HStack {
                Text(L.Manga.Covers.Filter.volume)
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Button {
                    vm.coverFilter.volOrder = (vm.coverFilter.volOrder == .asc) ? .desc : .asc
                } label: {
                    HStack {
                        Text("\(vm.coverFilter.volOrder.description)")
                        Image(systemName: vm.coverFilter.volOrder == .desc ? "chevron.up" : "chevron.down")
                    }
                }
                .tint(.secondary)
                .font(.subheadline)
                .buttonStyle(.borderless)
            }
        } header: {
            Text(L.order)
        }
    }
    
    @ViewBuilder
    func filterActions() -> some View {
        Section {
            Button(L.Filter.action) {
                showFilter = false
            }
            .tint(.accentColor)
            
            Button("Reset") {
                
            }
            .tint(.red)
        }
    }
}
