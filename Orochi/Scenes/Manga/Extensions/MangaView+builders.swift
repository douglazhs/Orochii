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
        List(selection: $vm.selection) {
            Section {
                if !vm.search {
                    // ALL MANGA INFORMATION
                    self.mangaInfoHeader()
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
    /// - Returns: All manga information
    @ViewBuilder
    func mangaInfoHeader() -> some View {
        Section {
            HStack {
                MangaStandardImage(
                    cover: manga.cover,
                    size: CGSize(
                        width: CGSize.dynamicImage.width,
                        height: CGSize.dynamicImage.height
                    )
                )
                self.mangaInfo()
            }.frame(maxHeight: CGSize.dynamicImage.height)
        } header: {
            HStack(alignment: .center) {
                Text(manga.title)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                Spacer()
                // MANGA TITLE LANGUAGE STANDARD PICKER
                LanguagePicker(
                    mockLanguages,
                    selectedLang: $vm.titleLang
                ).pickerStyle(.automatic)
            }.font(.callout)
        }
    }
    
    /// Manga information line
    /// - Parameters:
    ///   - leading: Leading item
    ///   - trailing: Trailing item
    @ViewBuilder
    func infoLine(
        leading: (String, String),
        trailing: (String, String)
    ) -> some View {
        HStack {
            self.item(title: leading.0, leading.1, .leading)
            Spacer()
            self.item(title: trailing.0, trailing.1, .trailing)
        }
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaInfo() -> some View {
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
                .frame(maxWidth: .infinity)
        }.buttonStyle(.borderedProminent)
    }
    
    /// Buttons actions
    /// - Returns: All buttons with the respective actions
    @ViewBuilder
    func actions() -> some View {
        HStack {
            // ANILIST BUTTON
            Button { vm.showAniList = true } label: {
                Text(MangaActions.aniList.description)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
                    .font(.footnote)
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $vm.showAniList) {
                AniListTracker(of: manga)
            }
            // ADD/REMOVE FROM LIBRARY BUTTON
            Button(role: vm.mangaOnLib ? .destructive : .none) {
                vm.mangaOnLib.toggle()
                vm.btnAction = (vm.btnAction == .addLib)
                ? .rmvLib
                : .addLib
            } label: {
                Text(vm.mangaOnLib
                     ? MangaActions.rmvLib.description
                     : MangaActions.addLib.description
                )
                .frame(maxWidth: .infinity)
                .font(.footnote)
            }
            .buttonStyle(.bordered)
            .foregroundColor(vm.mangaOnLib ? .red : .primary)
            .tint(vm.mangaOnLib ? Color.red : Color.primary)
        }
        .lineLimit(1)
        .fontWeight(.regular)
        .frame(maxWidth: .infinity)
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
}


