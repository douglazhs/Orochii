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
        VStack(alignment: .leading, spacing: 5.0) {
            chapterInfo()
            scanlationGroupInfo()
        }.padding(.vertical, 3.5)
    }
    
    /// Chapter info
    @ViewBuilder
    func chapterInfo() -> some View {
        HStack(alignment: .top, spacing: 5.0) {
            HStack(spacing: chapter.attributes?.volume != nil ? 2.5 : .zero) {
                // VOLUME
                Text(chapter.attributes?.volume != nil ? "[Vol.\(chapter.attributes?.volume ?? "")]" : "")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
                // CHAPTER NUMBER
                Text("Ch.\(chapter.attributes?.chapter ?? "")")
                    .font(.footnote)
                    .fontWeight(.semibold)
            }
            // CHAPTER TITLE
            title()
        }
    }
    
    /// Main chapter infos, as *title*
    @ViewBuilder
    func title() ->  some View {
        if !(chapter.attributes?.title?.isEmpty ?? false) &&
            chapter.attributes?.title != nil
        {
            HStack(spacing: 5.0) {
                Text("•")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .fontWeight(.heavy)
                Text(chapter.attributes?.title ?? "")
                    .font(.footnote)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .fontWeight(.semibold)
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
        HStack(alignment: .bottom) {
            // UPDATED
            if let group = chapter.relationships?.first(where: { $0.type == "scanlation_group" }),
               let updatedAt = group.attributes?.updatedAt
            {
                // UPDATED AT
                Text(
                    Date.fromString(updatedAt) +
                    " (\(Date.relativeDate(of: Int(Date.convert(updatedAt).timeIntervalSince1970))))"
                )
                .font(.footnote)
                .foregroundColor(Color(uiColor: .systemGray))
                // SCAN GROUP
                Text("~ " + (scanlationGroup ?? ""))
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            } else {
                Text("Unknown scanlation group")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
    }
}
