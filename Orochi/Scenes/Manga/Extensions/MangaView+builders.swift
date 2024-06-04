//
//  MangaView+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI
import NukeUI
import struct MangaDex.Cover

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
        .scrollContentBackground(.hidden)
        .background {
            BlurBackground(
                with: vm.api.buildURL(
                    for: .cover(
                        id: vm.manga.id,
                        fileName: vm.imgFileName(
                            of: vm.manga,
                            quality: vm.coverQuality.key
                        )
                    )
                ),
                radius: 100,
                opacity: 0.875
            )
        }
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
    
    /// Manga banner with some information, such as *genres*, *author* and *artirsr*
    @ViewBuilder
    func banner() -> some View {
        Section {
            VStack(alignment: .leading, spacing: 10.0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5.0) {
                        relationship("author", img: "person")
                        relationship("artist", img: "paintpalette")
                        tags()
                    }
                    .padding(.horizontal, 22.0)
                    .padding(.top, 10.0)
                }
                
                Text(vm.getGenres(of: vm.manga).joined(separator: ", "))
                    .padding(.horizontal, 22.0)
            }
            .padding(.vertical, 10.0)
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(Color.ORCH.primaryText)
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .listSectionSeparator(.hidden)
        .listRowBackground(bannerBackground())
        .frame(maxHeight: UIScreen.height * 0.375)
    }
    
    /// Manga relationship label
    @ViewBuilder
    func relationship(_ relation: String, img: String) -> some View {
        Label(vm.relationship(relation, with: vm.manga).notEmpty, systemImage: img)
            .padding(5.0)
            .background {
                RoundedRectangle(cornerRadius: 5.5)
                    .foregroundStyle(Color.ORCH.primaryText.opacity(0.25))
            }
            .overlay(
                RoundedRectangle(cornerRadius: 5.5)
                    .stroke(
                        Color.ORCH.primaryText,
                        lineWidth: 0.3
                    )
            )
            .padding(0.25)
    }
    
    /// Manga cover art as a banner
    @ViewBuilder
    func bannerBackground() -> some View {
        GeometryReader { geometry in
            let minY = geometry.frame(in: .named("MANGALIST")).minY
            let size = geometry.size
            let height = size.height + max(0, minY)
            
            BlurBackground(
                with: vm.api.buildURL(
                    for: .cover(
                        id: vm.manga.id,
                        fileName: vm.imgFileName(
                            of: vm.manga,
                            quality: vm.coverQuality.key
                        )
                    )
                ),
                radius: 0.0
            )
            .padding(.horizontal, min(0, -minY))
            .frame(width: size.width, height: height)
            .clipped()
            .mask {
                LinearGradient(
                    colors: [
                        Color.ORCH.background,
                        Color.ORCH.background,
                        Color.ORCH.background,
                        .clear
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
            .offset(CGSize(width: 0, height: min(0, -minY)))
        }
        .frame(height: UIScreen.height * 0.425)
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
                                quality: vm.coverQuality.key
                            )
                        )),
                        size: CGSize(
                            width: CGSize.dynamicImage.width,
                            height: CGSize.dynamicImage.height
                        )
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
        .listRowBackground(Color.clear)
        .zIndex(1)
    }
    
    /// Age content and manga formats
    @ViewBuilder
    func tags() -> some View {
        HStack(spacing: 5.0) {
            ForEach(vm.tags) { value in
                Text(value.title)
                    .tint(value.color)
                    .padding(5.0)
                    .background {
                        RoundedRectangle(cornerRadius: 5.5)
                            .foregroundStyle(value.color.opacity(0.185))
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5.5)
                            .stroke(
                                value.color,
                                lineWidth: 0.3
                            )
                    )
                    .padding(0.25)
                    .font(.caption)
                    .foregroundStyle(value.color)
            }
        }
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaTexts() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // AUTHOR & ARTIST
            MediaAttributes(
                leading: ("STATE", vm.manga.attributes?.state?.uppercased() ?? "-"),
                trailing: (String.Manga.year.uppercased(), vm.manga.attributes?.year.nilToStr ?? "-")
            )
            
            // STATUS & UPDADATED
            MediaAttributes(
                leading: ("DEMOGRAPHIC", vm.manga.attributes?.publicationDemographic?.uppercased() ?? "-"),
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
            HStack {
                Text(String.Manga.descHeader.uppercased())
                    .foregroundStyle(Color.ORCH.secondaryTitle)
                    .font(.footnote)
                    .fontWeight(.regular)
                Spacer()
                
                languageMenu()
            }
        }
        .listRowBackground(Color.clear)
    }
    
    /// Language choose menu
    @ViewBuilder
    func languageMenu() -> some View {
        Menu {
            Picker("", selection: $vm.descLang) {
                ForEach((vm.manga.attributes?.description ?? [:]).sorted(by: >), id: \.key) { key, _ in
                    Text((Locale.current.localizedString(
                        forLanguageCode: key
                    ) ?? key) + " - " + key.uppercased())
                }
            }
        } label: {
            Label(
                (((Locale.current.localizedString(
                    forLanguageCode: vm.descLang
                ) ?? vm.descLang) + " - " + vm.descLang)).uppercased(),
                systemImage: "chevron.up.chevron.down"
            )
            .font(.footnote)
            .fontWeight(.regular)
        }
        .menuOrder(.priority)
        .menuStyle(.button)
        .tint(Color.ORCH.button)
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
    
    /// Manga alternative titles
    @ViewBuilder
    func altTitles() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 17.5) {
                Text(vm.unwrapTitle(of: vm.manga))
                    .font(.headline)
                    .fontWeight(.heavy)
                    .frame(alignment: .center)
                ForEach(vm.convertedAltTitles().sorted(by: >), id: \.key) { country, title in
                    VStack(alignment: .leading) {
                        Text((Locale.current as NSLocale).localizedString(forLanguageCode: country)?.uppercased() ?? country)
                            .font(.caption)
                            .foregroundStyle(Color.ORCH.secondaryTitle)
                        Text(title)
                            .font(.subheadline)
                            .fontWeight(.heavy)
                            .foregroundStyle(Color.ORCH.primaryText)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}
