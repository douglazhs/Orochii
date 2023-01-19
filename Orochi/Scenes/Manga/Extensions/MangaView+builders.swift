//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

extension MangaView {
    /// All manga information, including  chapters
    @ViewBuilder
    func content() -> some View {
        List(selection: $vm.selection) {
            Group {
                // ALL MANGA INFORMATION
                self.mangaInfoArea()
                if !vm.search {
                    // MANGA ACTIONS
                    self.actions()
                    // MANGA DESCRIPTION
                    self.description()
                        .listSectionSeparator(.visible)
                }
                // MANGA CHAPTERS
                self.chapters()
                    .listSectionSeparator(!vm.search ? .visible : .hidden)
            }
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
        }.environment(\.editMode, .constant(
            vm.isEditingMode
            ? EditMode.active
            : EditMode.inactive
        ))
        .refreshable { }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(
            BlurBackground(with: manga.cover)
                .opacity(0.75)
        )
    }
    
    /// Manga information area, contatining all main details
    @ViewBuilder
    func mangaInfoArea() -> some View {
        Section {
            VStack(alignment: .leading) {
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
        }.listRowBackground(DarkOverlay(image: manga.cover))
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
        }.listRowBackground(Color.clear)
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
                }
                .contextMenu {
                    ChapterMenu() { _ in
                        // TODO: - Handle context menu actions
                    }
                } preview: { ChapterView(chapter, of: manga) }
                .fullScreenCover(isPresented: $showChapterReader) {
                    ChapterView(chapter, of: manga)
                }
            }
        } header: {
            self.chaptersHeader()
        }.listRowBackground(Color.clear)
    }
}
