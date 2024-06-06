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
            VStack(alignment: .leading, spacing: 10.0) {
                localesSection()
                Divider()
                orderSection()
            }
            .padding(32)
            .measureSize { size in
                viewSize = size
            }
            .background(blurBackground())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Filter") {
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
            .tint(Color.ORCH.button)
        }
        .padding(.horizontal)
        .padding(.vertical, 5.5)
    }
    
    @ViewBuilder
    func localesSection() -> some View {
        VStack(alignment: .leading, spacing: 15.0) {
            Button {
                vm.toggleLocaleSelection()
                Haptics.shared.play(.medium)
            } label: {
                Text(vm.markAll ? "NONE" :  "ALL")
                    .font(.footnote)
                    .underline(color: Color.ORCH.button)
                    .foregroundStyle(Color.ORCH.button)
            }
            .buttonStyle(.borderless)
            
            ForEach(vm.locales, id: \.self) { locale in
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
        }
        .font(.subheadline)
        .foregroundStyle(Color.ORCH.primaryText)
        .listRowBackground(Color.clear)
    }
    
    @ViewBuilder
    func orderSection() -> some View {
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
        .listRowBackground(Color.clear)
    }
}
