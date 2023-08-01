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
    func secondaryAttributes() -> some View {
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
                .foregroundColor(.secondary)
            Button { } label: {
                Text(vm.startDate.formatted(date: .numeric, time: .omitted))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
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
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
    
    /// Ended date
    @ViewBuilder
    func ended() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("ENDED")
                .font(.footnote)
                .foregroundColor(.secondary)
            Button { } label: {
                Text(vm.endDate.formatted(date: .numeric, time: .omitted))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
                    .font(.footnote)
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
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
    
    /// Manga score
    @ViewBuilder
    func score() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("SCORE")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Button {
                vm.currentPicker = .score
                showNumberPicker = true
            } label: {
                Text("\(String(format: "%.1f", vm.score)) / 10.0")
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
}
