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
        HStack(alignment: .top) {
            MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                    width: CGSize.standardImageCell.width,
                    height: CGSize.standardImageCell.height
                )
            )
            self.info()
        }.frame(maxHeight: CGSize.standardImageCell.height)
    }

    /// Organize all retrieved manga infos
    /// - Parameter manga: Retrieved manga
    /// - Returns: Manga vertical info
    @ViewBuilder
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5.5) {
            // TITLE
            Text(manga.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
            HStack {
                // AUTHOR
                Text("\(manga.author)")
                    .font(.caption)
                    .foregroundColor(Color(uiColor: .systemGray))
                Spacer()
                // YEAR
                Text("**\(manga.year)**")
                    .font(.caption2)
                    .fontWeight(.light)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
            // GENRES
            self.allGenres()
            Divider()
            // ACTUAL CHAPTER AND VOLUME
            HStack {
                Text("CH. 127 / -")
                Spacer()
                Text("VOL. 7 / -")
            }
            .foregroundColor(Color(uiColor: .systemGray))
            .font(.caption)
            /// MAIN INFORMATION
            self.main()
        }
    }
    
    /// All manga genres
    @ViewBuilder
    func allGenres() -> some View {
            HStack(alignment: .top) {
                if Constants.device == .pad {
                    ForEach(manga.genres, id: \.self) { genre in
                        Text(genre)
                            .padding(3.5)
                            .background {
                                Color.primary.opacity(0.1)
                                    .cornerRadius(4.5)
                            }
                    }
                } else {
                    Text(manga.genres.joined(separator: ", "))
                }
            }
            .font(.caption2)
            .fontWeight(.medium)
            .lineLimit(1)
            .foregroundColor(.secondary)
    }
    
    /// Main manga information
    /// - Returns: VStack with main information
    @ViewBuilder
    func main() -> some View {
        HStack {
            // STATUS
            self.infoLabel(
                manga.status.description.uppercased(),
                manga.status.config.icon,
                manga.status.config.color
            )
            Spacer()
            // LAST TIME UPDATED
            self.infoLabel(
                manga.lastUpdated,
                "arrow.triangle.2.circlepath",
                Color(uiColor: .systemGray)
            )
        }.foregroundColor(Color(uiColor: .systemGray))
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
