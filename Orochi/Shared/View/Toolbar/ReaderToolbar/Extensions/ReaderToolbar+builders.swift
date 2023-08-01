//
//  ReaderToolbar+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

extension ReaderToolbar {    
    /// Principal toolbar item
    @ViewBuilder
    func principalItem() -> some View {
        VStack {
            Text((vm.current.attributes?.title != nil && vm.current.attributes?.title != "")
                 ? vm.current.attributes?.title ?? "No title"
                 : "No title"
            )
            .font(.caption)
            .lineLimit(2)
            .multilineTextAlignment(.center)
            .fontWeight(.semibold)
            .foregroundColor(.primary)
            HStack(spacing: 2.5) {
                if vm.current.attributes?.volume != nil &&
                    !(vm.current.attributes?.volume?.isEmpty ?? false) {
                    Text("[Vol.\(vm.current.attributes?.volume ?? "")]")
                }
                Text("Ch.\(vm.current.attributes?.chapter ?? "")")
            }
            .foregroundColor(Color(uiColor: .systemGray))
            .font(.caption2)
        }.frame(maxWidth: .infinity, alignment: .center)
    }
    
    /// Reader preferences trailing button
    @ViewBuilder
    func readerPreferences() -> some View {
        Button {
            showReaderPreferences = true
        } label: {
            Image(systemName: "book")
        }
        .sheet(isPresented: $showReaderPreferences) {
            ReaderPreferencesView()
                .environmentObject(vm)
        }
    }
    
    /// Manga page slider
    @ViewBuilder
    func pageSlider() -> some View {
        VStack(spacing: 2.0) {
            UISliderView(
                value: $vm.actualPage,
                minValue: 0,
                maxValue: Double((vm.pagesCount()) - 1)
            )
            
            Text(String(format: "%.0f", (vm.actualPage + 1))
                 + " \(String.Common.of.uppercased()) "
                 + "\(vm.pagesCount())")
            .font(.caption2)
            
            Text("\(vm.pagesCount() - Int(vm.actualPage + 1)) pages left")
                .font(.caption2)
        }
    }
}
