//
//  ChapterStandardCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

extension ChapterStandardCell {
    /// Left manga cell information
    /// - Returns: Some manga information
    @ViewBuilder func leftInfo() -> some View {
        VStack(alignment: .center, spacing: 10) {
            Text("CH.\(chapter.number)")
                .font(.callout)
                .fontWeight(.semibold)
            Text(chapter.language)
                .font(.caption2)
            Text(chapter.volume)
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
    
    /// Right manga cell information
    /// - Returns: Some manga information
    @ViewBuilder func rightInfo() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(chapter.title)
                .font(.callout)
                .fontWeight(.semibold)
            Text("\(chapter.pages) PAGES")
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
                .fontWeight(.light)
                .fontWeight(.thin)
            HStack {
                Text("UPDATED: \(chapter.updated)")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
                Spacer()
                Text(chapter.scanGroup)
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
    }
}
