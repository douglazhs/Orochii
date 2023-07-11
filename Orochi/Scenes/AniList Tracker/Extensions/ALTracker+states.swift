//
//  ALTracker+states.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension ALTracker {
    /// Manga states section
    @ViewBuilder
    func statesSection() -> some View {
        HStack {
            // CHAPTER CHOOSER
            self.mangaChapters()
            // VOLUME CHOOSER
            self.mangaVol()
            // MANGA SCORE
            self.scoreSection()
        }
        .popover(isPresented: $showPopUp) {
           popUpType()
        }
    }
    
    /// PopUp type. Possibilities:
    ///  `Score`, `Volume`, `Chapter`
    @ViewBuilder
    func popUpType() -> some View {
        switch vm.currentPicker {
        case .score:
            TrackerPopUp(
                context: .score,
                selection: $vm.score
            )
        case .volume:
            TrackerPopUp(
                context: .volume,
                total: 100,
                selection: $vm.volume
            )
        case.chapter:
            TrackerPopUp(
                context: .chapter,
                total: 298,
                selection: $vm.chapter
            )
        }
    }
    
    /// Manga chapters picker
    @ViewBuilder
    func mangaChapters() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            Text("CH.")
                .font(.footnote)
                .foregroundColor(.secondary)
            Button {
                vm.currentPicker = .chapter
                showPopUp = true
            } label: {
                Text("\(String(format: "%.0f", vm.chapter)) / -")
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
    
    /// Manga volume picker
    @ViewBuilder
    func mangaVol() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("VOL.")
                .font(.footnote)
                .foregroundColor(.secondary)
            Button {
                vm.currentPicker = .volume
                showPopUp = true
            } label: {
                Text("\(String(format: "%.0f", vm.volume)) / -")
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
        
    /// Manga score section
    @ViewBuilder
    func scoreSection() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("SCORE")
                .font(.footnote)
                .foregroundColor(.secondary)
            Button {
                vm.currentPicker = .score
                showPopUp = true
            } label: {
                Text("\(String(format: "%.1f", vm.score)) / 10.0")
                    .frame(maxWidth: .infinity)
                    .lineLimit(1)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .tint(.primary.opacity(0.15))
        }
    }
}
