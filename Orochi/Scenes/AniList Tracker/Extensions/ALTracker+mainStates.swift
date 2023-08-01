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
                .foregroundColor(.secondary)
            Button {
                if let chCount = vm.alManga?.chapters, chCount <= 500 {
                    vm.currentPicker = .chapter
                    showNumberPicker = true
                } else {
                    showTextField = true
                }
            } label: {
                Text("\(String(format: "%.0f", vm.chapter)) / \(vm.alManga?.chapters?.unwrapNil() ?? "-")")
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
    
    /// Manga volumes picker
    @ViewBuilder
    func volumes() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("VOL.")
                .font(.footnote)
                .foregroundColor(.secondary)
            Button {
                vm.currentPicker = .volume
                showNumberPicker = true
            } label: {
                Text("\(String(format: "%.0f", vm.volume)) / \(vm.alManga?.volumes?.unwrapNil() ?? "-")")
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
    
    /// Manga tracking status
    @ViewBuilder
    func status() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("STATUS")
                .font(.footnote)
                .foregroundColor(.secondary)
            Menu {
                Picker("", selection: $vm.status) {
                    ForEach(MangaStatus.allCases) {
                        if $0 != .none {
                            Text($0.description)
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                    }
                }
            } label: {
                Text(vm.status.description.uppercased())
                    .frame(maxWidth: .infinity)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .tint(Color.primary.opacity(0.15))
        }
    }
}
