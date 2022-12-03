//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension MangaView {
    
    /// Manga all content
    /// - Returns: All manga information, including the chapters
    @ViewBuilder
    func content() -> some View {
        List(selection: $vm.selection) {
            Section {
                if !vm.search {
                    // THEMES
                    self.themes()
                        .listRowInsets(EdgeInsets(
                            top: 10,
                            leading: 0,
                            bottom: 10,
                            trailing: 0)
                        )
                    // ALL MANGA INFORMATION
                    self.mangaHeader()
                        .listSectionSeparator(.hidden)
                        .listRowSeparator(.hidden)
                    // MANGA ACTIONS: ANILIST, ADD & REMOVE
                    self.actions()
                    // MANGA DESCRIPTION
                    self.description()
                }
                self.chapters()
            }.listRowBackground(Color.clear)
        }.environment(\.editMode, .constant(
            vm.isEditingMode
            ? EditMode.active
            : EditMode.inactive
        ))
        .refreshable { }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(with: manga.cover))
    }
    
    /// Manga info header
    @ViewBuilder
    func mangaHeader() -> some View {
        Section {
            HStack {
                MangaStandardImage(
                    cover: manga.cover,
                    size: CGSize(
                        width: CGSize.dynamicImage.width,
                        height: CGSize.dynamicImage.height
                    )
                )
                self.mangaTexts()
            }.frame(maxHeight: CGSize.dynamicImage.height)
        }
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaTexts() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // AUTHOR & YEAR
            self.infoLine(
                leading: (String.Manga.author.uppercased() , manga.author),
                trailing: (String.Manga.year.uppercased(), manga.year)
            )
            // AUTHOR & UPDADATED
            self.infoLine(
                leading: (String.Manga.status.uppercased(), manga.status.description.uppercased()),
                trailing: (String.Manga.updated.uppercased(), manga.lastUpdated)
            )
            Divider()
            // GENRES
            self.item(
                title: String.Manga.genres.uppercased(),
                manga.genres.joined(separator: ", "),
                .leading
            ).lineLimit(2)
            Spacer()
            // START READING BUTTON
            self.startReadingButton()
        }.padding(.leading, 5)
    }
    
    /// Manga description
    /// - Returns: Manga description section
    @ViewBuilder
    func description() -> some View {
        Section {
            Text(manga.description)
                .font(.subheadline)
                .foregroundColor(.primary.opacity(0.825))
                .multilineTextAlignment(.leading)
                .fontWeight(.regular)
        } header: {
            HStack {
                Text(String.Manga.descHeader.uppercased())
                    .foregroundColor(.primary)
                Spacer()
                // MANGA DESCRIPTION LANGUAGE STANDARD PICKER
                LanguagePicker(
                    mockLanguages,
                    selectedLang: $vm.descLang
                )
            }
            .font(.callout)
            .fontWeight(.regular)
        }
    }
    
    /// Manga chapters list
    /// - Returns: All manga chapters cells
    @ViewBuilder
    func chapters() -> some View {
        Section {
            ForEach(ChapterDomain.samples) { chapter in
                Button { showChapterReader = true } label: {
                    ChapterStandardCell(chapter, editingMode: vm.isEditingMode)
                        .foregroundColor(chapter.read ? Color(uiColor: .systemGray) : Color.primary)
                        .id(chapter.id)
                }.contextMenu {
                    ChapterMenu() { _ in
                        // TODO: - Handle context menu actions
                    }
                } preview: { ChapterView(chapter, of: manga) }
                .fullScreenCover(isPresented: $showChapterReader) {
                    ChapterView(chapter, of: manga)
                }
            }
        } header: { self.chaptersHeader() }
    }
    
    /// Manga themes carousel
    @ViewBuilder
    func themes() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(manga.genres, id: \.self) { genre in
                    Text(genre)
                        .font(.caption2)
                        .foregroundColor(.primary.opacity(0.75))
                        .fontWeight(.semibold)
                        .padding(3.5)
                        .background {
                            Color.primary.opacity(0.1)
                                .cornerRadius(4.5)
                        }
                }
            }.padding(.leading, 17)
        }
    }
}
