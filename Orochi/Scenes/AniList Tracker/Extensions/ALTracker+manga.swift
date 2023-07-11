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
            HStack(alignment: .center, spacing: 5.0) {
                // MANGA COVER
                Image(manga?.cover ?? "")
                    .resizable()
                    .cornerRadius(2.5)
                    .frame(
                        width: CGSize.standardImageCell.width,
                        height: CGSize.standardImageCell.height
                    )
                // MANGA STATUS
                status()
            }.frame(maxHeight: CGSize.standardImageCell.height + 35.0)
        }
    }
    
    /// Manga tracking status
    @ViewBuilder
    func status() -> some View {
        EnumPicker("", selection: $vm.status)
            .pickerStyle(.wheel)
    }
}
