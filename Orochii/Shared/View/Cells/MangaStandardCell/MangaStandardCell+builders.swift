//
//  MangaStandardCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension MangaStandardCell {
    /// Manga list cell
    /// - Parameter manga: Received manga
    /// - Returns: Custom manga cell
    @ViewBuilder
    func cell() -> some View {
        HStack(alignment: .center) {
            /*MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                    width: CGSize.standardImageCell.width * 0.775,
                    height: CGSize.standardImageCell.height * 0.775
                )
            )*/
            info().padding(.leading, 5)
            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: CGSize.standardImageCell.height
        )
    }

    /// Organize all retrieved manga infos
    /// - Parameter manga: Retrieved manga
    /// - Returns: Manga vertical info
    @ViewBuilder
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5.5) {
            HStack {
                // TITLE
                Text(manga.attributes?.title?.en ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
            }
            // STATUS
            status()
        }
    }
    
    /// User status information
    @ViewBuilder
    func status() -> some View {
        VStack(alignment: .leading, spacing: 5.5) {
            Text("Ch. 1 ~ 154")
                .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
                .font(.caption2)
                .fontWeight(.light)
            
            HStack(alignment: .center, spacing: 4.5) {
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
                
                Text("8,0")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(Asset.Colors.primaryText.swiftUIColor)
            }
        }
    }
}
