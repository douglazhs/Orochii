//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import MarkdownUI
import struct MangaDex.Cover
import enum MangaDex.MangaHelpersKeys

extension MangaView {
    /// All manga information, including  chapters
    @ViewBuilder
    func content() -> some View {
        List(selection: $chSelection) {
            Group {
                sections()
            }
            .listRowSeparator(.hidden)
        }
        .coordinateSpace(name: "MANGALIST")
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
        .listStyle(.plain)
    }
    
    /// All List Sections
    @ViewBuilder
    func sections() -> some View {
        // BANNER
        banner()
        // ALL INFORMATION
        mangaInfoArea()
            .listSectionSeparator(.hidden, edges: .bottom)
        // DESCRIPTION
        description()
            .listSectionSeparator(.visible, edges: .bottom)
        // CHAPTERS
        chapters()
            .listRowSeparator(.visible)
            .listSectionSeparator(.hidden)
    }
    
    /// Manga banner with some information, such as *genres*, *author* and *artirst*
    @ViewBuilder
    func banner() -> some View {
        Section {
            VStack(alignment: .leading, spacing: 10.0) {
                title()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5.0) {
                        relationship(.author, img: "person")
                        relationship(.artist, img: "paintpalette")
                        tags()
                    }
                    .padding(.horizontal)
                    .padding(.top, 10.0)
                    .padding(.bottom, 7.5)
                }
                
                Text(vm.getGenres(of: vm.manga).joined(separator: ", "))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 22.0)
            }
            .fontWeight(.semibold)
            .padding(.vertical, 10.0)
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
    
    /// Manga title
    @ViewBuilder
    func title() -> some View {
        Text(vm.unwrapTitle(of: vm.manga))
            .font(.title3)
            .multilineTextAlignment(.leading)
            .fontWeight(.heavy)
            .textSelection(.enabled)
            .padding(.horizontal)
            .onTapGesture {
                showFullName = true
            }
            .alwaysPopover(isPresented: $showFullName) {
                altTitles()
                    .background(BackgroundClearView())
            }
    }
    
    /// Manga relationship label
    @ViewBuilder
    func relationship(_ relation: MangaHelpersKeys.Relationship, img: String) -> some View {
        Label(vm.relationship(relation, with: vm.manga).notEmpty, systemImage: img)
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(10.0)
            .glassEffect(in: .capsule)
            .shadow(radius: 0.75, x: 1.25, y: 1.25)
            .padding(1.0)
    }
    
    /// Manga information area, contatining all main details
    @ViewBuilder
    func mangaInfoArea() -> some View {
        Section {
            HStack(alignment: .bottom) {
                VStack(spacing: 15.0) {
                    MangaStandardImage(
                        url: vm.api.buildURL(for: .cover(
                            id: vm.manga.id,
                            fileName: vm.imgFileName(
                                of: vm.manga,
                                quality: vm.mDexCoverQuality.key
                            )
                        )),
                        size: .dynamicImage
                    )
                    .onTapGesture { [weak vm] in
                        showCover = true
                        vm?.getCovers()
                    }
                    // START READING BUTTON
                    startReadingButton()
                }
                mangaTexts().frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .zIndex(1)
    }
    
    /// Age content and manga formats
    @ViewBuilder
    func tags() -> some View {
        HStack(spacing: 5.0) {
            ForEach(vm.tags) { value in
                Text(value.title)
                    .font(.caption)
                    .padding(10.0)
                    .foregroundStyle(value.color)
                    .glassEffect(.regular.tint(value.color.opacity(0.125)), in: .capsule)
                    .shadow(radius: 0.65, x: 1.15, y: 1.15)
            }
        }
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaTexts() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // AUTHOR & ARTIST
            MediaAttributes(
                leading: (L.Manga.state.uppercased(), vm.manga.attributes?.state?.uppercased() ?? "-"),
                trailing: (L.Manga.year.uppercased(), vm.manga.attributes?.year.nilToStr ?? "-")
            )
            
            // STATUS & UPDADATED
            MediaAttributes(
                leading: (
                    L.Manga.demographic.uppercased(),
                    vm.manga.attributes?.publicationDemographic?.notEmpty.uppercased() ?? "-"
                ),
                trailing: (
                    L.Manga.country.uppercased(),
                    Locale.current.country(forLanguageCode: vm.manga.attributes?.originalLanguage).uppercased()
                )
            )
            // COUNTRY OF ORIGIN & YEAR
            MediaAttributes(
                leading: (L.Manga.status.uppercased(), vm.manga.attributes?.status?.uppercased() ?? ""),
                trailing: (L.Manga.updated.uppercased(), Date.fromString(vm.manga.attributes?.updatedAt ?? ""))
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
            Markdown(vm.switchDescLang())
                .markdownTextStyle(\.text) {
                    FontSize(15)
                    FontWeight(.regular)
                    ForegroundColor(.primary)
                }
                .markdownTextStyle(\.link) {
                    ForegroundColor(.accentColor)
                }
                .markdownTextStyle(\.strong) {
                    FontWeight(.semibold)
                }
                .markdownBlockStyle(\.listItem) { configuration in
                    configuration.label.markdownMargin(top: .em(0.5))
                }
                .animation(.bouncy(duration: 0.25).speed(1.5), value: vm.descLang)
                .textSelection(.enabled)
        } header: {
            HStack {
                Text(L.Manga.descriptionHeader.uppercased())
                    .foregroundStyle(.primary)
                    .font(.footnote)
                    .fontWeight(.regular)
                Spacer()
                
                languageMenu()
            }
        }
    }
    
    /// Language choose menu
    @ViewBuilder
    func languageMenu() -> some View {
        Menu {
            Picker("", selection: $vm.descLang) {
                ForEach((vm.manga.attributes?.description ?? [:]).sorted(by: >), id: \.key) { key, _ in
                    Text(Locale.current.country(forLanguageCode: key).capitalized + " - " + key)
                }
            }
        } label: {
            Label(
                (Locale.current.country(forLanguageCode: vm.descLang).lowercased() + " - " +
                 vm.descLang.lowercased()),
                systemImage: "chevron.up.chevron.down"
            )
            .font(.footnote)
            .fontWeight(.semibold)
        }
        .menuOrder(.fixed)
        .tint(.accentColor)
        .controlSize(.regular)
        .buttonStyle(.bordered)
        .foregroundStyle(
            !(vm.manga.attributes?.description?.isEmpty ?? false)
            ? Color.accentColor
            : .secondary
        )
        .disabled((vm.manga.attributes?.description) == nil)
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
                            scanlationGroup: vm.relationship(.scanlationGroup, with: ch),
                            isOneshot: vm.getTag(.oneshot, of: vm.manga) != nil,
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
            .onChange(of: chSelection) { _, _ in
                if chSelection.count == vm.filtered.count {
                    vm.selectAll = true
                } else { vm.selectAll = false }
            }
        } else {
            loadHandler()
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
                Text(L.Manga.noChapters)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                Spacer()
            }
        }
    }
    
    /// Manga alternative titles
    @ViewBuilder
    func altTitles() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 17.5) {
                Text(vm.unwrapTitle(of: vm.manga))
                    .font(.headline)
                    .fontWeight(.heavy)
                    .frame(alignment: .center)
                    .textSelection(.enabled)
                ForEach(vm.convertedAltTitles().sorted(by: >), id: \.key) { country, title in
                    VStack(alignment: .leading) {
                        Text((Locale.current as NSLocale).localizedString(forLanguageCode: country)?.uppercased() ?? country)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .foregroundStyle(.primary)
                            .textSelection(.enabled)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}
