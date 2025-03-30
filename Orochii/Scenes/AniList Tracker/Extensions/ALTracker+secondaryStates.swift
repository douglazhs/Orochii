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
                .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
            Text(vm.startDate.formatted(date: .numeric, time: .omitted))
                .frame(maxWidth: .infinity)
                .foregroundColor(Asset.Colors.secondaryTitle.swiftUIColor)
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
                .frame(height: 30.5, alignment: .center)
                .background(Asset.Colors.actionBackground.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 4.25))
        }
    }
    
    /// Ended date
    @ViewBuilder
    func ended() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text(L.Tracker.Info.ended)
                .font(.footnote)
                .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
            Text(vm.endDate.formatted(date: .numeric, time: .omitted))
                .frame(maxWidth: .infinity)
                .foregroundColor(Asset.Colors.secondaryTitle.swiftUIColor)
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
                .frame(height: 30.5, alignment: .center)
                .background(Asset.Colors.actionBackground.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: 4.25))
        }
    }
    
    /// Manga score
    @ViewBuilder
    func score() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(L.Tracker.Info.score)
                    .font(.footnote)
                    .foregroundStyle(Asset.Colors.primaryText.swiftUIColor)
            }
            PickerTextField(
                data: Array(stride(from: 0.0, through: 10.0, by: 0.1)),
                dataFormat: "%.1f",
                placeholder: "",
                field: .score,
                selection: $vm.score
            )
            .frame(height: 30.5, alignment: .center)
            .overlay {
                Text("\(String(format: "%.1f", vm.score ?? 0)) / 10")
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(Asset.Colors.secondaryTitle.swiftUIColor)
            }
        }
    }
}
