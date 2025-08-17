//
//  ALTracker+secondaryStates.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension ALTracker {
    /// Manga secondary states
    @ViewBuilder
    func secondaryStates() -> some View {
        HStack {
            score()
            started()
            ended()
        }.lineLimit(1)
    }
    
    /// Started date
    @ViewBuilder
    func started() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(L.Tracker.Info.started)
                .font(.footnote)
                .foregroundColor(.primary)
            Text(vm.startDate.formatted(date: .numeric, time: .omitted))
                .frame(maxWidth: .infinity)
                .foregroundColor(.secondary)
                .font(.footnote)
                .fontWeight(.medium)
                .overlay {
                    DatePicker(
                        "",
                        selection: $vm.startDate,
                        displayedComponents: [.date]
                    )
                    .tint(.accentColor)
                    .blendMode(.destinationOver)
                    .labelsHidden()
                }
                .frame(height: 35.0, alignment: .center)
                .glassEffect(.regular.tint(.accentColor.opacity(0.5)), in: .capsule)
        }
    }
    
    /// Ended date
    @ViewBuilder
    func ended() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(L.Tracker.Info.ended)
                .font(.footnote)
                .foregroundColor(.primary)
            Text(vm.endDate.formatted(date: .numeric, time: .omitted))
                .frame(maxWidth: .infinity)
                .foregroundColor(.secondary)
                .font(.footnote)
                .fontWeight(.medium)
                .overlay {
                    DatePicker(
                        "",
                        selection: $vm.endDate,
                        displayedComponents: [.date]
                    )
                    .tint(.accentColor)
                    .blendMode(.destinationOver)
                    .labelsHidden()
                }
                .frame(height: 35.0, alignment: .center)
                .glassEffect(.regular.tint(.accentColor.opacity(0.5)), in: .capsule)
        }
    }
    
    /// Manga score
    @ViewBuilder
    func score() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(L.Tracker.Info.score)
                    .font(.footnote)
                    .foregroundStyle(.primary)
            }
            PickerTextField(
                data: Array(stride(from: 0.0, through: 10.0, by: 0.1)),
                dataFormat: "%.1f",
                placeholder: "",
                field: .score,
                selection: $vm.score
            )
            .frame(height: 35.0, alignment: .center)
            .glassEffect(.regular.tint(.accentColor.opacity(0.5)), in: .capsule)
            .overlay {
                Text("\(String(format: "%.1f", vm.score ?? 0)) / 10")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
