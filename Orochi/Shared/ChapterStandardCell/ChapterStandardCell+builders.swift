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
            // CHAPTER NUMBER
            Text("CH.\(chapter.number)")
                .font(.subheadline)
                .fontWeight(.semibold)
            // LANGUAGE
            Text(chapter.language)
                .font(.caption2)
            // VOLUME
            Text(chapter.volume)
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
    
    /// Right manga cell information
    /// - Returns: Some manga information
    @ViewBuilder func rightInfo() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 10) {
                    // TITLE
                    Text(chapter.title)
                        .font(.subheadline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fontWeight(.semibold)
                    // NUMBER OF PAGES
                    Text("\(chapter.pages) PAGES")
                        .font(.caption2)
                        .foregroundColor(Color(uiColor: .systemGray))
                        .fontWeight(.light)
                        .fontWeight(.thin)
                }
                Spacer()
                // DOWNLOADED
                if chapter.downloaded {
                    Divider()
                    Image(systemName: "arrow.down")
                        .foregroundColor(
                            Color.accentColor.opacity(0.85)
                        )
                        .font(.caption)
                }
            }
            HStack(alignment: .center) {
                // UPDATED
                Text("UPDATED: \(chapter.updated)")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
                Spacer()
                // SCAN GROUP
                Text(chapter.scanGroup)
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
    }
}
