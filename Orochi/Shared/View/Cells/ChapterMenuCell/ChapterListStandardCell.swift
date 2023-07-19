//
//  ChapterListStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import SwiftUI
import struct MangaDex.Chapter

struct ChapterListStandardCell: View {
    var chapter: Chapter
    
    init(_ chapter: Chapter) {
        self.chapter = chapter
    }
    var body: some View {
        HStack(alignment: .center, spacing: 12.5) {
            // INFORMATIONS, AS CHAPTER NUMBER, VOLUME AND PAGES
            VStack {
                Text("**Ch.\(chapter.attributes?.chapter ?? "")**")
                Text("**\(chapter.attributes?.volume ?? "")**")
                Text("**\(chapter.attributes?.pages ?? 0)** pages")
            }
            .font(.caption2)
            .foregroundColor(Color(uiColor: .systemGray))
            // TITLE
            Text(chapter.attributes?.title ?? "")
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
}

struct ChapterListStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        /*ChapterListStandardCell(ChapterDomain.samples[0])*/
    }
}
