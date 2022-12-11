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
        // CHAPTER CHOOSER
        self.mangaChapters()
        // VOLUME CHOOSER
        self.mangaVol()
    }
    
    /// Manga chapters picker
    @ViewBuilder
    func mangaChapters() -> some View {
        Section {
            HStack {
                TextField("", value: $vm.chapter, format: .number)
                    .keyboardType(.numberPad)
                Stepper("") {
                    vm.chapter += 1
                } onDecrement: {
                    vm.chapter -= 1
                }
            }
        } header: {
            Text("CHAPTER")
                .font(.footnote)
        } footer: {
            Text("TOTAL: 242")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    
    /// Manga volume picker
    @ViewBuilder
    func mangaVol() -> some View {
        Section {
            HStack {
                TextField("", value: $vm.volume, format: .number)
                    .keyboardType(.numberPad)
                Stepper("") {
                    vm.volume += 1
                } onDecrement: {
                    vm.volume -= 1
                }
            }
        } header: {
            Text("VOLUME")
                .font(.footnote)
        } footer: {
            Text("TOTAL: Unknown")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
    
    /// Manga score section
    @ViewBuilder
    func scoreSection() -> some View {
        Section {
            HStack {
                TextField("", value: $vm.score, format: .number)
                    .keyboardType(.numberPad)
                Stepper("") {
                    vm.score += 1
                } onDecrement: {
                    vm.score -= 1
                }
            }
        }
    }
}
