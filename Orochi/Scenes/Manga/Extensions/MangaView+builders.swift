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
        List(selection: $vm.chSelection) {
            Group {
                // ALL INFORMATION
                mangaInfoArea()
                // ACTIONS
                actions()
                // DESCRIPTION
                description()
                    .listSectionSeparator(.visible)
                // CHAPTERS
                chapters()
                    .listSectionSeparator(.visible)
            }
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
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
                mangaTexts()
            }.frame(maxHeight: CGSize.dynamicImage.height)
        }
        .listRowBackground(
            DarkOverlay(url: vm.api.buildURL(for: .cover(
                id: vm.manga.id,
                fileName: vm.imgFileName(of: vm.manga))
            ))
            .frame(height: CGSize.dynamicImage.height + 20.0)
            .clipped()
        )
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaTexts() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // AUTHOR & YEAR
            infoLine(
                leading: (String.Manga.author.uppercased() , vm.relationship("author", with: vm.manga)),
                trailing: (String.Manga.year.uppercased(), "\(vm.manga.attributes?.year ?? 0)")
            )
            // AUTHOR & UPDADATED
            infoLine(
                leading: (String.Manga.status.uppercased(), (vm.manga.attributes?.status ?? "").uppercased()),
                trailing: (String.Manga.updated.uppercased(), Date.fromString(vm.manga.attributes?.updatedAt ?? ""))
            )
            Divider()
            // GENRES
            item(
                title: String.Manga.genres.uppercased(),
                vm.getGenres(of: vm.manga),
                .leading
            )
            Spacer()
        }.padding(.leading, 5)
    }
    
    /// Manga description
    /// - Returns: Manga description section
    @ViewBuilder
    func description() -> some View {
        Section {
            if isTruncated {
                descriptionText()
                    .frame(
                        height: UIScreen.height * 0.225,
                        alignment: .top
                    )
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black, location: 0),
                                .init(color: isTruncated ? .clear : .black, location: 1)
                            ]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    )
            } else {
                descriptionText()
            }
        } header: {
            HStack {
                Text(String.Manga.descHeader.uppercased())
                Spacer()
                // MANGA DESCRIPTION LANGUAGE PICKER
                EnumPicker("", selection: $vm.descLang)
                    .pickerStyle(.menu)
            }
        }
        .listRowBackground(Color.clear)
    }
    
    /// Description attributed text
    @ViewBuilder
    func descriptionText() -> some View {
        Text(vm.switchDescLang())
            .readSize { size in
                withAnimation(.linear) {
                    descSize = size
                    isTruncated = size.height >= UIScreen.height * 0.225
                }
            }
            .onTapGesture {
                withAnimation(.linear) {
                    isTruncated.toggle()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(.primary.opacity(0.825))
            .font(.subheadline)
            .fontWeight(.regular)
    }
    
    /// Manga chapters list
    /// - Returns: All manga chapters cells
    @ViewBuilder
    func chapters() -> some View {
        if !vm.loadingFeed, let chapters = vm.chapters, !chapters.isEmpty {
            Section {
                ForEach(chapters) { ch in
                    VStack(alignment: .leading, spacing: 5.0) {
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
                        .contextMenu {
                            ChapterMenu() { _ in
                                // TODO: - Handle context menu actions
                            }
                        }
                        .fullScreenCover(isPresented: $showChapterReader) {
                            ChapterView(
                                vm.selectedChapter!,
                                vm.chapters ?? [],
                                of: vm.manga
                            )
                        }
                    }
                }
            } header: {
                chaptersHeader()
            }
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
}
