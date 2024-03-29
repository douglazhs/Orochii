//
//  ChapterStandardCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

extension ChapterStandardCell {
    /// Left manga cell information
    @ViewBuilder
    func leftInfo() -> some View {
        VStack(alignment: .center, spacing: 5) {
            // CHAPTER NUMBER
            Text("CH.\(chapter.number)")
                .font(.subheadline)
                .fontWeight(.semibold)
            // VOLUME
            Text(chapter.volume)
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }
    
    /// Right manga cell information
    @ViewBuilder
    func rightInfo() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(alignment: .center) {
                // MAIN INFO
                self.mainInfo()
                Spacer()
                // DOWNLOADED
                self.downloadInfo()
            }
            // SCAN UPDATE INFO
            self.scanInfo()
        }
    }
    
    /// Main chapter infors, as *title*
    @ViewBuilder
    func mainInfo() ->  some View {
        // TITLE
        Text(chapter.title)
            .font(.subheadline)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .fontWeight(.semibold)
    }
    
    /// Download chapter informations
    @ViewBuilder
    func downloadInfo() -> some View {
        if chapter.downloaded && !editingMode {
            Image(systemName: "arrow.down")
                .foregroundColor(
                    Color.accentColor.opacity(0.85)
                )
                .font(.caption)
        }
    }
    
    /// Chapter scan informations
    @ViewBuilder
    func scanInfo() -> some View {
        HStack(alignment: .bottom) {
            // UPDATED
            Text(chapter.updated)
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
