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
            Text("STARTED")
                .font(.footnote)
                .foregroundColor(Color.ORCH.primaryText)
            Text(vm.startDate.formatted(date: .numeric, time: .omitted))
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.ORCH.secondaryTitle)
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
                .background(Color.ORCH.actionBackground)
                .clipShape(RoundedRectangle(cornerRadius: 4.25))
        }
    }
    
    /// Ended date
    @ViewBuilder
    func ended() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("ENDED")
                .font(.footnote)
                .foregroundColor(Color.ORCH.primaryText)
            Text(vm.endDate.formatted(date: .numeric, time: .omitted))
                .frame(maxWidth: .infinity)
                .foregroundColor(Color.ORCH.secondaryTitle)
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
                .background(Color.ORCH.actionBackground)
                .clipShape(RoundedRectangle(cornerRadius: 4.25))
        }
    }
    
    /// Manga score
    @ViewBuilder
    func score() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("SCORE")
                    .font(.footnote)
                    .foregroundStyle(Color.ORCH.primaryText)
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
                    .foregroundStyle(Color.ORCH.secondaryTitle)
            }
        }
    }
}
