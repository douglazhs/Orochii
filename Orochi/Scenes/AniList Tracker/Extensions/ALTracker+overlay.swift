//
//  ALTracker+overlay.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/07/23.
//

import SwiftUI

extension ALTracker {
    /// Track locally overlay
    @ViewBuilder
    func trackLocallyOverlay() -> some View {
        if !vm.trackingLocally {
            ZStack {
                Color.black.opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 20.0) {
                    trackingInfo()
                    
                    Divider()
                    
                    Button {
                        withAnimation(.spring()) {
                            vm.trackingLocally = true
                        }
                    } label: {
                        Label(
                            vm.alManga?.mediaListEntry != nil
                            ? "Track locally"
                            : "Start tracking",
                            systemImage: vm.alManga?.mediaListEntry != nil
                            ? "icloud.and.arrow.down"
                            : "play.fill"
                        )
                        .font(.subheadline)
                        .fontWeight(.black)
                    }
                    .buttonStyle(.borderless)
                }.padding()
            }
        }
    }
    
    /// Tracking mang information
    @ViewBuilder
    func trackingInfo() -> some View {
        Group {
            VStack(spacing: 20.0) {
                HStack(spacing: 30.0) {
                    VStack(alignment: .leading, spacing: 5.0) {
                        Text("STATUS")
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                        if vm.alManga?.mediaListEntry != nil {
                            Text(vm.alManga?.status ?? "")
                        } else { Text("-") }
                    }
                    VStack(alignment: .center, spacing: 5.0) {
                        Text("PROGRESS")
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                        Text("CH. \(vm.alManga?.mediaListEntry?.progress?.unwrapNil() ?? "-")" +
                             "/\(vm.alManga?.chapters?.unwrapNil() ?? "-")")
                    }
                    VStack(alignment: .trailing, spacing: 5.0) {
                        Text("UPDATED")
                            .font(.caption2)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                        if vm.alManga?.mediaListEntry != nil {
                            Text(Date.getDate(
                                of: vm.alManga?.mediaListEntry?.updatedAt ?? 0,
                                format: "dd MMM yy"
                            ))
                        } else { Text("-") }
                    }
                }
            }
        }
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .fontWeight(.semibold)
        .foregroundColor(.primary.opacity(0.85))
    }
}
