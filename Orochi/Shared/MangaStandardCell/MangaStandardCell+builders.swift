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
        VStack(alignment: .leading, spacing: 5.5) {
            // TITLE
            Text(manga.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .lineLimit(1)
            HStack {
                // AUTHOR
                Text("**\(manga.author)**")
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
            Text(manga.genres.joined(separator: ", "))
                .font(.caption)
                .fontWeight(.medium)
                .lineLimit(1)
                .foregroundColor(Color(uiColor: .systemGray))
            // MANGA INFO
            self.main()
        }
    }
    
    /// Main manga information
    /// - Returns: VStack with main information
    @ViewBuilder
    func main() -> some View {
        VStack(alignment: .leading, spacing: 5.5) {
            // LAST TIME UPDATED
            self.infoLabel(
                manga.lastUpdated,
                "arrow.triangle.2.circlepath",
                Color(uiColor: .systemGray)
            )
            .foregroundColor(Color(uiColor: .systemGray))
            HStack {
                // STATUS
                self.infoLabel(
                    manga.status.description.uppercased(),
                    manga.status.config.icon,
                    manga.status.config.color
                )
                .foregroundColor(Color(uiColor: .systemGray))
                Spacer()
                if !isSearch {
                    // ANILIST BUTOON
                    Button { anilist = true } label: {
                        Text(String.Name.aniList.uppercased())
                            .font(.caption)
                            .fontWeight(.medium)
                    }.buttonStyle(.bordered)
                    .foregroundColor(.primary)
                    .coordinateSpace(name: "Button")
                    .sheet(isPresented: $anilist) {
                        AniListTracker(of: manga)
                            .presentationDragIndicator(.visible)
                    }
                }
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
