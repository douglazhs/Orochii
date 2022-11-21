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
        HStack {
            MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                   width: UIScreen.width/5.5,
                   height: UIScreen.width/4
                )
            )
            self.info()
        }
    }

    /// Organize all retrieved manga infos
    /// - Parameter manga: Retrieved manga
    /// - Returns: Manga vertical info
    @ViewBuilder
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(manga.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
            Text(manga.genres.joined(separator: ", "))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(Color(uiColor: .systemGray))
            Spacer()
            HStack(spacing: 3.5) {
                Label {
                    Text("**\(manga.author)**")
                        .font(.caption2)
                        .fontWeight(.light)
                } icon: {
                    Image(systemName: "person.crop.circle")
                        .foregroundColor(Color(uiColor: .systemGray))
                }.font(.caption2)
                Spacer()
                Divider()
                Text("\(String.Discovery.year): **\(manga.year)**")
                    .font(.caption2)
                    .fontWeight(.light)
            }
            self.statusInfo(
                manga.lastUpdated,
                manga.status
            )
        }
        .padding(.vertical, 5)
    }

    /// Anime status info, such as actual `Status`: Ex.: ``Ongoing`` and `Last updated`: Ex.: ``2022-09-10``
    /// - Parameters:
    ///   - lastUpdated: Last time manga was updated
    ///   - status: Actual manga status. Ex.: ``Ongoing``
    /// - Returns: Manga status infos
    @ViewBuilder
    func statusInfo(
        _ lastUpdated: String,
        _ status: MangaStatus
    ) -> some View {
        HStack {
            Label {
                Text("\(status.config.name.uppercased())")
                    .font(.caption2)
                    .fontWeight(.semibold)
            } icon: {
                Image(systemName: status.config.icon)
                    .font(.caption2)
                    .foregroundColor(status.config.color)
            }
            Spacer()
            Divider()
            Text("\(String.Discovery.lastUpdated): **\(lastUpdated)**")
                .font(.caption2)
                .fontWeight(.light)
                .foregroundColor(Color(uiColor: .systemGray))
        }
    }

}
