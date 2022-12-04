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
        HStack(alignment: .center, spacing: 5.0) {
            VStack {
                Text("CH. **\(chapter.number)**")
                Text("**\(chapter.volume)**")
                Text("**\(chapter.pages)** pages")
            }
            .font(.caption2)
            .foregroundColor(Color(uiColor: .systemGray))
            Divider()
            VStack (alignment: .leading, spacing: 7.5){
                Text(chapter.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(chapter.language)
                    .font(.caption2)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
    }
}

struct ChapterListStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        ChapterListStandardCell(ChapterDomain.samples[0])
    }
}
