//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension MangaView {
    @ViewBuilder
    /// Manga all content
    /// - Returns: All manga information, including the chapters
    func content() -> some View {
        List {
            Section {
                self.header()
                self.actions()
                self.description()
            }
            .listRowBackground(Color.clear)
            Section { self.chapters() } header: {
                Text(String.Manga.chapHeader.uppercased())
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
    /// Manga info header
    /// - Returns: All manga information
    func header() -> some View {
        let portrait = UIScreen.width < UIScreen.height
        let aspectRatio = 245.0 / 165.0
        let width = (portrait ? UIScreen.width : UIScreen.height) * 0.325
        HStack {
            MangaStandardImage(
                cover: manga.cover,
                size: CGSize(
                    width: width,
                    height: width
                ),
                aspectRatio: aspectRatio
            )
            self.mangaInfo()
        }
    }
    
    /// Manga information line
    /// - Parameters:
    ///   - leading: Leading item
    ///   - trailing: Trailing item
    /// - Returns: Manga information items
    @ViewBuilder func infoLine(
        leading: (String, String),
        trailing: (String, String)
    ) -> some View {
        HStack {
            self.item(
                title: leading.0,
                leading.1,
                .leading
            )
            Spacer()
            self.item(
                title: trailing.0,
                trailing.1,
                .trailing
            )
        }
    }
    
    /// Manga informations
    /// - Returns: All grouped manga informations
    @ViewBuilder
    func mangaInfo() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            self.infoLine(
                leading: (String.Manga.author.uppercased() , manga.author),
                trailing: (String.Manga.year.uppercased(), manga.year)
            )
            self.infoLine(
                leading: (String.Manga.status.uppercased(), manga.status.config.name.uppercased()),
                trailing: (String.Manga.updated.uppercased(), manga.lastUpdated))
            Divider()
            self.item(
                title: String.Manga.genres.uppercased(),
                manga.genres.joined(separator: ", "),
                .leading
            ).lineLimit(2)
            Spacer()
            self.startReadingButton()
        }
        .padding(.leading, 5)
        .padding(.vertical, 7)
    }
    
    /// Manga information item
    /// - Parameters:
    ///   - title: Manga title
    ///   - description: Manga item
    ///   - alignment: Item alignment
    /// - Returns: Custom manga information item
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
    
    /// Start reading button
    /// - Returns: Custom start  reading book
    @ViewBuilder
    func startReadingButton() -> some View {
        Button {
            // TODO: Start to read the manga
        } label: {
            Text(String.Manga.startReading.uppercased())
                .lineLimit(1)
                .foregroundColor(.primary)
                .font(.footnote)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }.buttonStyle(.borderedProminent)
    }
    
    /// Buttons actions
    /// - Returns: All buttons with the respective actions
    @ViewBuilder
    func actions() -> some View {
        HStack {
            ForEach(Actions.allCases, id: \.self) { action in
                Button(role: (action == .rmvLib) ? .destructive : .none) {
                    vm.btnAction = action
                } label: {
                    Text(action.name.uppercased())
                        .lineLimit(1)
                        .foregroundColor((action != .rmvLib) ? .primary : .red)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
                .tint((action != .rmvLib) ? Color.primary : Color.red)
            }
        }
    }
    
    /// Manga description
    /// - Returns: Manga description section
    @ViewBuilder
    func description() -> some View {
        Section {
            Text(manga.description)
                .font(.callout)
                .multilineTextAlignment(.leading)
        } header: {
            Text(String.Manga.descHeader.uppercased())
                .font(.callout)
                .foregroundColor(.primary)
                .fontWeight(.regular)
        }
    }
    
    /// Manga chapters list
    /// - Returns: All manga chapters cells
    @ViewBuilder
    func chapters() -> some View {
        ForEach(ChapterDomain.samples) { chapter in
            ChapterStandardCell(chapter)
                .contextMenu {
                    // TODO: - Context actions
                    Button { } label: {
                        Label {
                            Text(String.ContextMenu.markAsRead)
                        } icon: { Image(systemName: "eye.fill") }
                    }
                }
        }
    }
}


