//
//  ALTracker+mainStates.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension ALTracker {
    /// Manga main states section
    @ViewBuilder
    func mainStates() -> some View {
        HStack {
            // STATUS
            status()
            // CHAPTERS
            chapters()
            // VOLUMES
            volumes()
        }
        .lineLimit(1)
    }
    
    /// Manga chapters picker
    @ViewBuilder
    func chapters() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("CH.")
                .font(.footnote)
                .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
            PickerTextField(
                data: Array(stride(
                    from: 0,
                    through: Double(vm.alManga?.chapters ?? 2000),
                    by: 1
                )),
                dataFormat: "%.0f",
                placeholder: "",
                field: .chapter,
                selection: $vm.chapter
            )
            .frame(height: 30.5, alignment: .center)
            .overlay {
                Text("\(String(format: "%.0f", vm.chapter ?? 0)) / \(vm.alManga?.chapters.nilToStr ?? "-")")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
            }
        }
    }
    
    /// Manga volumes picker
    @ViewBuilder
    func volumes() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("VOL.")
                .font(.footnote)
                .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
            PickerTextField(
                data: Array(stride(
                    from: 0,
                    through: Double(vm.alManga?.volumes ?? 500),
                    by: 1
                )),
                dataFormat: "%.0f",
                placeholder: "",
                field: .volume,
                selection: $vm.volume
            )
            .frame(height: 30.5, alignment: .center)
            .overlay {
                Text("\(String(format: "%.0f", vm.volume ?? 0)) / \(vm.alManga?.volumes.nilToStr ?? "-")")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
            }
        }
    }
    
    /// Manga tracking status
    @ViewBuilder
    func status() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(L.Tracker.Info.status)
                .font(.footnote)
                .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
            Menu {
                Picker("", selection: $vm.status) {
                    ForEach(MangaStatus.allCases) {
                        if $0 != .none {
                            Text($0.description)
                        }
                    }
                }
            } label: {
                Text(vm.status.description.uppercased())
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(Asset.Colors.secondaryTitle.swiftUIColor)
            }
            .frame(height: 30.5, alignment: .center)
            .background(Asset.Colors.actionBackground.swiftUIColor)
            .clipShape(RoundedRectangle(cornerRadius: 4.25))
        }
    }
}
