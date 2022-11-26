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
        List(selection: $selection) {
            Section {
                self.header()
                self.actions()
                self.description()
            }.listRowBackground(Color.clear)
            Section { self.chapters() } header: {
                HStack {
                    Text("\(ChapterDomain.samples.count) " + String.Manga.chapHeader.uppercased())
                        .font(.callout)
                        .foregroundColor(.primary)
                        .fontWeight(.regular)
                    Spacer()
                    Button { vm.ascending.toggle() } label: {
                        Label(
                            (vm.ascending
                             ? String.Filter.ascending
                             : String.Filter.descending).uppercased(),
                            systemImage: vm.ascending ? "chevron.down" : "chevron.up"
                        )
                        .font(.caption)
                        .fontWeight(.medium)
                    }.buttonStyle(.borderless)
                }
            }.listRowBackground(Color.clear)
        }.environment(\.editMode, .constant(
            isEditingMode
            ? EditMode.active
            : EditMode.inactive
        ))
        .refreshable { }
        .listStyle(.inset)
        .scrollContentBackground(.hidden)
        .background(ViewBackground(with: manga.cover))
    }
    
    @ViewBuilder
    /// Manga info header
    /// - Returns: All manga information
    func header() -> some View {
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
            }
        } header: {
            HStack {
                Text(manga.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                Spacer()
                LanguagePicker(
                    ["en-US", "pt-BR", "es-SP"],
                    selectedLang: $vm.titleLang
                )
            }.font(.callout)
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
                leading: (String.Manga.status.uppercased(), manga.status.description.uppercased()),
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
            Button(role: vm.mangaOnLib ? .destructive : .none) {
                vm.mangaOnLib.toggle()
                vm.btnAction = (vm.btnAction == .addLib)
                ? .rmvLib
                : .addLib
            } label: {
                Label(
                    vm.mangaOnLib
                    ? MangaActions.rmvLib.description
                    : MangaActions.addLib.description,
                    systemImage: vm.mangaOnLib ? "trash" : "books.vertical.fill"
                ).frame(maxWidth: .infinity)
            }
            .buttonStyle(.bordered)
            .foregroundColor(vm.mangaOnLib ? .red : .primary)
            .tint(vm.mangaOnLib ? Color.red : Color.primary)
            
            Button { vm.btnAction = .aniList } label: {
                Text(MangaActions.aniList.description)
                    .frame(maxWidth: .infinity)
            }.buttonStyle(.bordered)
        }
        .lineLimit(1)
        .font(.footnote)
        .fontWeight(.medium)
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
                LanguagePicker(
                    ["en-US", "pt-BR", "es-SP"],
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
        ForEach(ChapterDomain.samples) { chapter in
            Button { chapterReader = true } label: {
                ChapterStandardCell(chapter)
                    .foregroundColor(chapter.read ? Color(uiColor: .systemGray) : Color.primary)
                    .disabled(chapter.read)
            }.contextMenu {
                ChapterMenu() { _ in
                    // TODO: - Handle context menu actions
                }
            } preview: { ChapterView(chapter, of: manga) }
            .fullScreenCover(isPresented: $chapterReader) {
                ChapterView(chapter, of: manga)
            }
        }
    }
    
    /// Select/Deselect all chapters button
    @ViewBuilder
    func selectButton() -> some View {
        if isEditingMode {
            Button { selectAll.toggle() } label:
            { Text(selectAll ? String.Common.none : String.Common.all) }
        }
    }
    
    /// Editable view actions
    @ViewBuilder
    func editButton() ->  some View {
        Button { isEditingMode.toggle() } label:{
            if isEditingMode {
                Text(String.Common.done)
            } else { Label (String.Manga.selectChapters, systemImage: "checklist") }
        }
    }
}


