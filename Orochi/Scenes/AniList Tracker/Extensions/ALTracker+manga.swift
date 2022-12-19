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
            HStack(alignment: .top, spacing: 5) {
                // MANGA COVER
                Image(manga.cover)
                    .resizable()
                    .cornerRadius(2.5)
                    .frame(width: 65, height: 90)
                VStack(alignment: .leading) {
                    // TITLE & YEAR
                    self.titleYear()
                    // MANGA AUTHOR
                    Text(manga.author)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }.frame(maxHeight: 90)
        }
    }
    
    /// Manga title and release year
    @ViewBuilder
    func titleYear() -> some View {
        HStack {
            // MANGA TITLE
            Text(manga.title)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Spacer()
            // MANGA RELEASE YEAR
            Text(manga.year)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    /// Manga tracking status
    @ViewBuilder
    func status() -> some View {
        EnumPicker("", selection: $vm.status)
            .pickerStyle(.wheel)
    }
}
