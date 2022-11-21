//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension MangaView {
    @ViewBuilder func content() -> some View {
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
        .listStyle(.plain)
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
    
    @ViewBuilder func description() -> some View {
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
        ForEach(0..<30) { i in
            self.chapterCell(i)
        }
    }
    
    @ViewBuilder func chapterCell(_ i: Int) -> some View {
        HStack (alignment: .center, spacing: 15) {
            VStack(alignment: .center, spacing: 10) {
                Text("CH.\(i)")
                    .font(.callout)
                    .fontWeight(.semibold)
                Text("pt-br")
                    .font(.caption2)
                Text("20 PAGES")
                    .font(.caption2)
                    .foregroundColor(Color(uiColor: .systemGray))
                    .fontWeight(.light)
                    .fontWeight(.thin)
            }
            Divider()
            VStack(alignment: .leading, spacing: 10) {
                Text("Blood and war")
                    .font(.callout)
                    .fontWeight(.semibold)
                Text("vol. \(i)")
                    .font(.caption2)
                HStack {
                    Text("UPDATED: 2022-10-21")
                        .font(.footnote)
                        .foregroundColor(Color(uiColor: .systemGray))
                    Spacer()
                    Text("Gravity Scans")
                        .font(.footnote)
                        .foregroundColor(Color(uiColor: .systemGray))
                }
            }
        }
    }
}


