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
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.height
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
        VStack(alignment: .leading, spacing: 7) {
            // TITLE
            Text(manga.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
            // AUTHOR
            Text("**\(manga.author)**")
                .font(.caption)
                .foregroundColor(Color(uiColor: .systemGray))
            Divider()
            // MANGA INFO
            HStack(alignment: .top) {
                self.main()
                Spacer()
                Divider()
                self.secondary()
            }
        }.padding(.vertical, 5)
    }
    
    /// Main manga information
    /// - Returns: VStack with main information
    @ViewBuilder
    func main() -> some View {
        VStack(alignment: .leading, spacing: 7) {
            // GENRES
            Text(manga.genres.joined(separator: ", "))
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(2)
                .foregroundColor(Color(uiColor: .systemGray))
            // STATUS
            self.infoLabel(
                manga.status.description.uppercased(),
                manga.status.config.icon,
                manga.status.config.color
            )
            // LAST TIME UPDATED
            self.infoLabel(
                manga.lastUpdated,
                "arrow.triangle.2.circlepath",
                Color(uiColor: .systemGray),
                isItalic: true
            )
            .foregroundColor(Color(uiColor: .systemGray))
        }
    }
    
    /// Secondary manga  information
    /// - Returns: Vstack with secondary information
    @ViewBuilder
    func secondary() -> some View {
        VStack(alignment: .center, spacing: 7) {
            // PUBLISHED
            Text(manga.published.uppercased())
                .font(.caption2)
                .fontWeight(.light)
            // YEAR
            Text("\(String.Discovery.year): **\(manga.year)**")
                .font(.caption2)
                .fontWeight(.light)
            if !isSearch {
                // ANILIST
                Button {
                    // TODO: - Edit anilist
                } label: {
                    Text(String.Name.aniList.uppercased())
                        .font(.caption)
                }.buttonStyle(.bordered)
            }
        }
    }

    /// Manga Info custom label
    /// - Parameters:
    ///   - name: Label name
    ///   - icon: Icon name
    ///   - color: Label icon color
    /// - Returns: Custom manga informaion label
    @ViewBuilder
    func infoLabel(
        _ name: String,
        _ icon: String,
        _ color: Color = Color(uiColor: .systemGray),
        isItalic: Bool = false
    ) -> some View {
        Label {
            Text(name)
                .fontWeight(.semibold)
                .italic(isItalic)
        } icon: {
            Image(systemName: icon)
                .foregroundColor(color)
        }.font(.caption2)
    }
}
