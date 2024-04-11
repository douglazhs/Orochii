//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import NukeUI

extension MangaView {
    /// All manga information, including  chapters
    @ViewBuilder
    func content() -> some View {
        List(selection: $chSelection) {
            Group {
                // ALL INFORMATION
                mangaInfoArea()
                    .listSectionSeparator(.visible, edges: .bottom)
                // GENRES
                genres()
                    .listSectionSeparator(.visible, edges: .bottom)
                // CONTENT AND FORMAT
                tags()
                    .listSectionSeparator(.visible, edges: .bottom)
                // DESCRIPTION
                description()
                    .listSectionSeparator(.visible, edges: .bottom)
                // CHAPTERS
                chapters()
                    .listRowSeparator(.visible)
                    .listSectionSeparator(.hidden)
            }
            .listRowSeparator(.hidden)
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
        .background(Color.ORCH.background)
    }
    
    /// Manga information area, contatining all main details
    @ViewBuilder
    func mangaInfoArea() -> some View {
        Section {
            HStack(alignment: .top) {
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
            }.padding(.top)
        }.listRowBackground(Color.clear)
    }
    
    /// Age content and manga formats
    @ViewBuilder
    func tags() -> some View {
        Section {
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
                }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        } header: {
            Text("TAGS")
                .foregroundStyle(Color.ORCH.secondaryTitle)
                .font(.footnote)
                .fontWeight(.regular)
        }
        .listRowBackground(Color.clear)
    }
    
    /// Genres and themes
    @ViewBuilder
    func genres() -> some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vm.getGenres(of: vm.manga), id: \.self) { genre in
                        Text(genre)
                            .font(.footnote)
                            .fontWeight(.medium)
                            .padding(7.5)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 7.25))
                    }
                }.padding(.horizontal)
            }.listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        } header: {
            Text("GENRES")
                .foregroundStyle(Color.ORCH.secondaryTitle)
                .font(.footnote)
                .fontWeight(.regular)
        }.listRowBackground(Color.clear)
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaTexts() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // AUTHOR & ARTIST
            MediaAttributes(
                leading: (String.Manga.author.uppercased(), vm.relationship("author", with: vm.manga).notEmpty),
                trailing: (String.Manga.year.uppercased(), vm.manga.attributes?.year.nilToStr ?? "-")
            )
            
            // STATUS & UPDADATED
            MediaAttributes(
                leading: ("ARTIST", vm.relationship("artist", with: vm.manga).notEmpty),
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
            Text(vm.switchDescLang())
                .foregroundStyle(Color.ORCH.primaryText)
                .font(.subheadline)
                .fontWeight(.regular)
        } header: {
            Text(String.Manga.descHeader.uppercased())
                .foregroundStyle(Color.ORCH.secondaryTitle)
                .font(.footnote)
                .fontWeight(.regular)
        }
        .listRowBackground(Color.clear)
    }
    
    /// Manga chapters list
    /// - Returns: All manga chapters cells
    @ViewBuilder
    func chapters() -> some View {
        if !vm.loadingFeed, !vm.chapters.isEmpty {
            Section {
                ForEach(vm.filtered, id: \.id) { ch in
                    Button { [weak vm] in
                        vm?.selectedChapter = ch
                    } label: {
                        ChapterStandardCell(
                            ch,
                            scanlationGroup: vm.relationship("scanlation_group", with: ch),
                            editingMode: vm.isEditingMode
                        )
                    }
                    .contextMenu {
                        ChapterMenu { _ in
                            // TODO: - Handle context menu actions
                        }
                    }
                }
            } header: {
                chaptersHeader()
            }
            .listRowBackground(Color.clear)
            .fullScreenCover(item: $vm.selectedChapter) {
                ChapterView(
                    $0,
                    vm.chapters,
                    of: vm.manga
                )
            }
        } else {
            loadHandler()
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
        }
    }
    
    /// Load chapters handler
    @ViewBuilder
    func loadHandler() -> some View {
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
                    .foregroundColor(Color.ORCH.primaryText)
                Spacer()
            }
        }
    }
}
