//
//  ChapterStandardCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

extension ChapterStandardCell {
    @ViewBuilder
    func content() -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 5.0) {
                chapterInfo()
                scanlationGroupInfo()
            }
            Spacer()
        }
        .padding(.vertical, 3.5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    /// Chapter info
    @ViewBuilder
    func chapterInfo() -> some View {
        HStack(alignment: .top, spacing: 5.0) {
            HStack(spacing: chapter.attributes?.volume != nil ? 2.5 : .zero) {
                // CHAPTER NUMBER
                Text("CH. \(chapter.attributes?.chapter ?? "-")")
                    .font(.footnote)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.ORCH.secondaryTitle)
            }
            // CHAPTER TITLE
            title()
        }
    }
    
    /// Main chapter infos, as *title*
    @ViewBuilder
    func title() -> some View {
        if !(chapter.attributes?.title?.isEmpty ?? false) &&
            chapter.attributes?.title != nil {
            HStack(spacing: 5.0) {
                Text("•")
                    .foregroundColor(Color.ORCH.secondaryText)
                    .font(.caption)
                    .fontWeight(.heavy)
                Text(chapter.attributes?.title ?? "")
                    .font(.footnote)
                    .lineLimit(1)
                    .multilineTextAlignment(.leading)
                    .truncationMode(.tail)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.ORCH.secondaryTitle)
            }
        } else { EmptyView() }
    }
    
    /// Download chapter informations
    @ViewBuilder
    func downloadInfo() -> some View {
        /*if chapter.downloaded && !editingMode {
            Image(systemName: "arrow.down")
                .foregroundColor(
                    Color.accentColor.opacity(0.85)
                )
                .font(.caption)
        }*/
    }
    
    /// Chapter scan informations
    @ViewBuilder
    func scanlationGroupInfo() -> some View {
        HStack(alignment: .bottom, spacing: .zero) {
            // UPDATED
            if let createdAt = chapter.attributes?.createdAt {
                // UPDATED AT
                Text(Date.fromString(createdAt).uppercased())
            }
            if let scanlationGroup,
                !scanlationGroup.isEmpty {
                // SCAN GROUP
                Text(" • " + scanlationGroup.uppercased())
            } else {
                Text("• MISSING SCAN GROUP")
            }
        }
        .foregroundStyle(Color.ORCH.primaryText)
        .font(.footnote)
        .lineLimit(1)
    }
}
