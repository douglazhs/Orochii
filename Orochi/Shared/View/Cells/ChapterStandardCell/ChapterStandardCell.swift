//
//  ChapterStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI
import struct MangaDex.Chapter

struct ChapterStandardCell: View {
    var chapter: Chapter
    var scanlationGroup: String?
    var editingMode: Bool
    
    init(
        _ chapter: Chapter,
        scanlationGroup: String? = nil,
        editingMode: Bool = false
    ) {
        self.chapter = chapter
        self.scanlationGroup = scanlationGroup
        self.editingMode = editingMode
    }
    var body: some View {
        content()
            /*.badge(
                chapter.downloaded
                ? Text(Image(systemName: "arrow.down"))
                        .foregroundColor(
                            Color.accentColor.opacity(0.85)
                        )
                        .font(.caption)
                : Text("")
            )*/
    }
}

struct ChapterStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
