//
//  ChapterListStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI

struct ChapterListStandardCell: View {
    var chapter: ChapterDomain
    
    init(_ chapter: ChapterDomain) {
        self.chapter = chapter
    }
    var body: some View {
        HStack(alignment: .center, spacing: 12.5) {
            // INFORMATIONS, AS CHAPTER NUMBER, VOLUME AND PAGES
            VStack {
                Text("**CH. \(chapter.number)**")
                Text("**\(chapter.volume)**")
                Text("**\(chapter.pages)** pages")
            }
            .font(.caption2)
            .foregroundColor(Color(uiColor: .systemGray))
            // TITLE
            Text(chapter.title)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

struct ChapterListStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        ChapterListStandardCell(ChapterDomain.samples[0])
    }
}
