//
//  ChapterStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

struct ChapterStandardCell: View {
    var chapter: ChapterDomain
    var editingMode: Bool
    
    init(_ chapter: ChapterDomain, editingMode: Bool = false) {
        self.chapter = chapter
        self.editingMode = editingMode
    }
    var body: some View {
        HStack (alignment: .center, spacing: 7.5) {
            leftInfo()
            Text("•")
                .foregroundColor(.secondary)
                .font(.caption)
                .fontWeight(.heavy)
            rightInfo()
        }
        .badge(
            Text(Image(systemName: "arrow.down"))
                .foregroundColor(
                    Color.accentColor.opacity(0.85)
                )
                .font(.caption)
        )
    }
}

struct ChapterStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        ChapterStandardCell(ChapterDomain.samples[0])
    }
}
