//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension MangaView {
    @ViewBuilder
    func content() -> some View {
        List {
            Section {
                self.header()
                self.actions()
                self.description()
            }
            .listRowBackground(Color.clear)
            Section { self.chapters() } header: {
                Text("CHAPTERS")
                    .font(.callout)
                    .foregroundColor(.primary)
                    .fontWeight(.regular)
            }
            .listRowBackground(Color.clear)
        }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(name: manga.cover))
    }
    
    @ViewBuilder
    func header() -> some View {
        HStack {
            MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                    width: UIScreen.width/3,
                    height: UIScreen.width/2
                )
            )
            self.mangaInfo()
        }
    }
    
    @ViewBuilder
    func mangaInfo() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                self.item(
                    title: "AUTHOR",
                    manga.author,
                    .leading
                )
                Spacer()
                self.item(
                    title: "YEAR",
                    manga.year,
                    .trailing
                )
            }
            HStack {
                self.item(
                    title: "STATUS",
                    manga.status.config.name.uppercased(),
                    .leading
                )
                Spacer()
                self.item(
                    title: "UPDATED",
                    manga.lastUpdated,
                    .trailing
                )
            }
            Divider()
            self.item(
                title: "GENRES",
                manga.genres.joined(separator: ", "),
                .leading
            ).lineLimit(2)
            Spacer()
            self.startReadingButton()
        }
        .padding(.leading, 5)
        .padding(.vertical, 5)
    }
    
    @ViewBuilder
    func startReadingButton() -> some View {
        Button {
            // TODO: Start to read the manga
        } label: {
            Text("START READING")
                .lineLimit(1)
                .foregroundColor(.primary)
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
    }
    
    @ViewBuilder
    func item(
        title: String,
        _ description: String,
        _ alignment: HorizontalAlignment
    ) -> some View {
        VStack(alignment: alignment, spacing: 2.5) {
            Text(title)
                .font(.caption2)
                .foregroundColor(Color(uiColor: .systemGray))
            Text(description)
                .font(.caption)
                .fontWeight(.semibold)
        }
    }
    
    @ViewBuilder func actions() -> some View {
        HStack {
            Button { } label: {
                Text("ADD")
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.primary)
            Button { } label: {
                Text("ANILIST")
                    .lineLimit(1)
                    .foregroundColor(.primary)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.primary)
            Button(role: .destructive) { } label: {
                Text("REMOVE")
                    .lineLimit(1)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .tint(.red)
        }
    }
    
    @ViewBuilder
    func description() -> some View {
        Section {
            Text(manga.description)
                .font(.callout)
                .multilineTextAlignment(.leading)
        } header: {
            Text("DESCRIPTION")
                .font(.callout)
                .foregroundColor(.primary)
                .fontWeight(.regular)
        }
    }
    
    @ViewBuilder
    func chapters() -> some View {
        ForEach(ChapterDomain.samples) { chapter in
            self.chapterCell(chapter)
                .contextMenu {
                    // TODO: - Context actions
                    Button { } label: {
                        Label {
                            Text("Mark as read")
                        } icon: { Image(systemName: "eye.fill") }
                    }
                }
        }
    }
    
    @ViewBuilder func chapterCell(_ chapter: ChapterDomain) -> some View {
        HStack (alignment: .center, spacing: 15) {
            VStack(alignment: .center, spacing: 10) {
                Text("CH.\(chapter.number)")
                    .font(.callout)
                    .fontWeight(.semibold)
                Text("pt-br")
                    .font(.caption2)
                Text(chapter.volume)
                    .font(.caption2)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
            Divider()
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
}


