//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import NukeUI
import Combine

extension MangaView {
    /// All manga information, including  chapters
    @ViewBuilder
    func content() -> some View {
        List(selection: $vm.chSelection) {
            Group {
                // ALL INFORMATION
                mangaInfoArea()
                // CONTENT AND FORMAT
                tags()
                // DESCRIPTION
                description()
                    .listSectionSeparator(.visible)
                // CHAPTERS
                chapters()
                    .listSectionSeparator(.visible)
            }
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
            .fontDesign(.rounded)
        }
        .overlay(alignment: .top) {
            ActionPopUp(
                message: vm.actionMessage,
                action: $vm.occurredAct
            )
        }
        .environment(\.editMode, .constant(
            vm.isEditingMode
            ? EditMode.active
            : EditMode.inactive
        ))
        .refreshable { vm.refresh() }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background {
            if let url = vm.api.buildURL(for: .cover(
                id: vm.manga.id,
                fileName: vm.imgFileName(of: vm.manga)
            )) {
                BlurBackground(with: url)
            }
        }
    }
    
    /// Manga information area, contatining all main details
    @ViewBuilder
    func mangaInfoArea() -> some View {
        Section {
            VStack(alignment: .leading, spacing: .zero) {
                // MAIN INFORMATION
                HStack {
                    MangaStandardImage(
                        url: vm.api.buildURL(for: .cover(
                            id: vm.manga.id,
                            fileName: vm.imgFileName(of: vm.manga)
                        )),
                        size: CGSize(
                            width: CGSize.dynamicImage.width,
                            height: CGSize.dynamicImage.height
                        )
                    )
                    mangaTexts().frame(maxHeight: .infinity, alignment: .top)
                }.padding([.horizontal, .top])
                startReadingButton()
                    .frame(maxWidth: CGSize.dynamicImage.width)
                    .padding([.leading, .top])
                // GENRES
                genres()
            }
        }
        .listRowBackground(Color.clear)
        .background(alignment: .center) {
            DarkOverlay(url: vm.api.buildURL(for: .cover(
                id: vm.manga.id,
                fileName: vm.imgFileName(of: vm.manga))
            ))
        }
        .clipShape(Rectangle())
        .listRowInsets(.init(
            top: 0,
            leading: 0,
            bottom: 0,
            trailing: 0
        ))
    }
    
    /// Age content and manga formats
    @ViewBuilder
    func tags() -> some View {
        if !vm.tags.isEmpty {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vm.tags) { value in
                        Text(value.title)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .padding(7.5)
                            .background(.tint.opacity(0.185), in: RoundedRectangle(cornerRadius: 7.25))
                            .tint(value.color)
                            .foregroundColor(value.color)
                    }
                }.padding(.horizontal)
            }
            .padding(.vertical)
            .listRowBackground(Color.clear)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    /// Genres and themes
    @ViewBuilder
    func genres() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(vm.getGenres(of: vm.manga), id: \.self) { genre in
                    Text(genre)
                        .font(.caption)
                        .fontWeight(.medium)
                        .padding(6.5)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 7.25))
                }
            }.padding(.horizontal)
        }.padding(.vertical)
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaTexts() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // AUTHOR & ARTIST
            MediaAttributes(
                leading: (String.Manga.author.uppercased(), vm.relationship("author", with: vm.manga)),
                trailing: (String.Manga.year.uppercased(), vm.manga.attributes?.year?.unwrapNil() ?? "-")
            )
            
            // STATUS & UPDADATED
            MediaAttributes(
                leading: ("ARTIST", vm.relationship("artist", with: vm.manga)),
                trailing: ("COUNTRY", vm.manga.attributes?.originalLanguage?.uppercased() ?? "-")
            )
            // COUNTRY OF ORIGIN & YEAR
            MediaAttributes(
                leading: (String.Manga.status.uppercased(), vm.manga.attributes?.status?.uppercased() ?? ""),
                trailing: (String.Manga.updated.uppercased(), Date.fromString(vm.manga.attributes?.updatedAt ?? ""))
            )
            Divider()
            // ACTIONS
            actions()
        }
        .padding(.leading, 5)
        .lineLimit(1)
    }
    
    /// Manga description
    /// - Returns: Manga description section
    @ViewBuilder
    func description() -> some View {
        Section {
            descriptionText()
        } header: {
            HStack {
                Text(String.Manga.descHeader.uppercased())
                Spacer()
                // MANGA DESCRIPTION LANGUAGE PICKER
                EnumPicker("", selection: $vm.descLang)
                    .pickerStyle(.menu)
                    
            }.lineLimit(1)
        }
        .listRowBackground(Color.clear)
    }
    
    /// Description attributed text
    @ViewBuilder
    func descriptionText() -> some View {
        Text(vm.switchDescLang())
            .foregroundColor(.primary.opacity(0.825))
            .font(.subheadline)
            .fontWeight(.regular)
    }
    
    /// Manga chapters list
    /// - Returns: All manga chapters cells
    @ViewBuilder
    func chapters() -> some View {
        if !vm.loadingFeed, !vm.chapters.isEmpty {
            Section {
                ForEach(vm.chapters, id: \.id) { ch in
                    Button {
                        vm.selectedChapter = ch
                        showChapterReader = true
                    } label: {
                        ChapterStandardCell(
                            ch,
                            scanlationGroup: vm.relationship("scanlation_group", with: ch),
                            editingMode: vm.isEditingMode
                        )
                    }
                    .task { [weak vm] in
                        if (vm?.hasReachedEnd(of: ch) ?? false) {
                            vm?.fetchMore()
                        }
                    }
                    .contextMenu {
                        ChapterMenu() { _ in
                            // TODO: - Handle context menu actions
                        }
                    }
                    .fullScreenCover(isPresented: $showChapterReader) {
                        ChapterView(
                            vm.selectedChapter!,
                            vm.chapters,
                            of: vm.manga
                        )
                    }
                }
            } header: { chaptersHeader() }
            .listRowBackground(Color.clear)
        } else {
            loadHandling()
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
        }
    }
    
    /// Load chapters handling
    @ViewBuilder
    func loadHandling() -> some View {
        if vm.loadingFeed {
            HStack {
                Spacer()
                ActivityIndicator()
                Spacer()
            }
        } else {
            HStack {
                Spacer()
                Text("No chapters found :(")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(Color(uiColor: .systemGray))
                Spacer()
            }
        }
    }
    
    /// Action message
    @ViewBuilder
    func headerPopUp() -> some View {
        Text(vm.actionMessage)
            .font(.caption)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity)
            .listRowBackground(Color.clear)
            .padding(2.5)
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
