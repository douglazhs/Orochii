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
        HStack (alignment: .center, spacing: 15) {
            self.leftInfo()
            Divider()
            self.rightInfo()
        }
    }
}

struct ChapterStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        ChapterStandardCell(ChapterDomain.samples[0])
    }
}
