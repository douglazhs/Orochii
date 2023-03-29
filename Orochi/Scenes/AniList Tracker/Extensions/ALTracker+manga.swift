//
//  ALTrackerView+manga.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/11/22.
//

import SwiftUI

extension ALTracker {
    /// Manga information
    @ViewBuilder
    func mangaSection() -> some View {
        VStack {
            // TITLE
            self.title()
            HStack(alignment: .top, spacing: 5) {
                // MANGA COVER
                Image(manga.cover)
                    .resizable()
                    .cornerRadius(2.5)
                    .frame(width: 77.5, height: 110)
                // MANGA STATUS
                self.status()
            }.frame(maxHeight: 110)
        }
    }
    
    /// Manga title and release year
    @ViewBuilder
    func title() -> some View {
        HStack {
            // MANGA TITLE
            Text(manga.title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Spacer()
        }
    }
    
    /// Manga tracking status
    @ViewBuilder
    func status() -> some View {
        EnumPicker("", selection: $vm.status)
            .pickerStyle(.wheel)
    }
}
