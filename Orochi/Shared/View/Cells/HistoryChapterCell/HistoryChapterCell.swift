//
//  HistoryChapterCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/12/22.
//

import SwiftUI

struct HistoryChapterCell: View {
    var chapter: ChapterDomain
    
    init(of chapter: ChapterDomain) {
        self.chapter = chapter
    }
    
    var body: some View {
        self.cell()
    }
}

struct HistoryChapterCell_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChapterCell(of: ChapterDomain.samples[0])
    }
}
