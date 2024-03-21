//
//  ReaderToolbar+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

extension ReaderToolbar {    
    /// Reader preferences trailing button
    @ViewBuilder
    func readerPreferences() -> some View {
        Button {
            showReaderPreferences = true
        } label: {
            Image(systemName: "book")
        }
        .fullScreenCover(isPresented: $showReaderPreferences) {
            ReaderPreferencesView()
                .environmentObject(vm)
        }
    }
    
    /// Manga page slider
    @ViewBuilder
    func pageSlider() -> some View {
        VStack(spacing: 2.0) {
            if vm.format == .normal {
                Slider(
                    value: $vm.actualPage,
                    in: 0...Double(vm.pages.count + 1),
                    step: 1
                ) { } minimumValueLabel: {
                    Text("\(Int(vm.actualPage + 1))")
                        .font(.footnote)
                        .fontWeight(.medium)
                } maximumValueLabel: {
                    Text("\(vm.pages.count)")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
                Text("\(vm.pages.count - Int(vm.actualPage + 1)) pages left")
                    .font(.caption)
                    .fontWeight(.medium)
            }
        }
    }
}
