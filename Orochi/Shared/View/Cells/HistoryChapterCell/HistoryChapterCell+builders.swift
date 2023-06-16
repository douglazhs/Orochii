//
//  HistoryChapterCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

extension HistoryChapterCell  {
    /// All chapter cell information
    @ViewBuilder
    func cell() -> some View {
        HStack(alignment: .top, spacing: 7.5) {
            self.leftInfo()
            Divider()
            self.rightInfo()
            Spacer()
        }.frame(maxHeight: 50)
    }
    
    /// Left chapter info, such as chapter `number` and `volume`
    @ViewBuilder
    func leftInfo() -> some View {
        VStack(alignment: .center, spacing: 7.5) {
            Text("CH. \(chapter.number)")
                .fontWeight(.semibold)
                .font(.subheadline)
            Text(chapter.volume)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .foregroundColor(.primary)
    }
    
    /// Right chapter info, such as `title` and `number` of pages
    @ViewBuilder
    func rightInfo() -> some View {
        VStack(alignment: .leading, spacing: 7.5) {
            Text(chapter.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            Text("\(chapter.pagesImages.count) pages")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
