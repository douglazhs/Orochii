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
                mangaInfoArea()
                if !vm.search {
                    // MANGA ACTIONS
                    actions()
                    // MANGA DESCRIPTION
                    description()
                        .listSectionSeparator(.visible)
                }
                // MANGA CHAPTERS
                chapters()
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
        .background {
            if let url = vm.api.buildURL(for: .cover(
                id: vm.manga.id,
                fileName: vm.fileName()
            )) {
                AsyncImage(url: url, placeholder: { Placeholder() })
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 25.0, opaque: true)
                    .overlay { Color.black.opacity(0.85).edgesIgnoringSafeArea(.all) }
            } else {
                BlurBackground(with: .view_background)
            }
        }
    }
    
    /// Manga information area, contatining all main details
    @ViewBuilder
    func mangaInfoArea() -> some View {
        Section {
            VStack(alignment: .leading) {
                HStack {
                    MangaStandardImage(
                        url: vm.api.buildURL(for: .cover(
                            id: vm.manga.id,
                            fileName: vm.fileName()
                        )),
                        size: CGSize(
                            width: CGSize.dynamicImage.width,
                            height: CGSize.dynamicImage.height
                        )
                    )
                    mangaTexts()
                }.frame(maxHeight: CGSize.dynamicImage.height)
            }
        }.listRowBackground(
            ZStack {
                DarkOverlay(url: vm.api.buildURL(for: .cover(
                    id: vm.manga.id,
                    fileName: vm.fileName())
                ))    
                Color.black.opacity(0.8)
            }
            .frame(height: CGSize.dynamicImage.height + 20.0)
            .clipped()
            .overlay(Divider().foregroundColor(Color(.systemGray)), alignment: .top)
            .overlay(Divider().foregroundColor(Color(.systemGray)), alignment: .bottom)
        )
    }
    
    /// All grouped manga informations
    @ViewBuilder
    func mangaTexts() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            // AUTHOR & YEAR
            infoLine(
                leading: (String.Manga.author.uppercased() , vm.getValue("author")),
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
                vm.getGenres(),
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
            if vm.truncation != nil {
                descriptionText()
                    .lineLimit(8)
                    .mask(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .black, location: 0),
                                .init(color: .clear, location: 1)
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
                    .foregroundColor(.primary)
                Spacer()
                // MANGA DESCRIPTION LANGUAGE PICKER
                EnumPicker("", selection: $vm.descLang)
                    .pickerStyle(.menu)
            }
            .font(.callout)
            .fontWeight(.regular)
        }.listRowBackground(Color.clear)
    }
    
    /// Description attributed text
    @ViewBuilder
    func descriptionText() -> some View {
        Text(vm.switchDescLang())
            .onTapGesture { vm.truncation = vm.truncation == .tail ? nil : .tail }
            .font(.subheadline)
            .foregroundColor(.primary.opacity(0.825))
            .multilineTextAlignment(.leading)
            .fontWeight(.regular)
    }
    
    /// Manga chapters list
    /// - Returns: All manga chapters cells
    @ViewBuilder
    func chapters() -> some View {
        Section {
            if let chapters = vm.chapters {
                ForEach(chapters) { ch in
                    Button {
                        vm.selectedChapter = ch
                        showChapterReader = true
                    } label: {
                        ChapterStandardCell(
                            ch,
                            scanlationGroup: vm.getValue("scanlation_group", from: ch),
                            editingMode: vm.isEditingMode
                        )
                        /*.foregroundColor(ch.read ? Color(uiColor: .systemGray) : Color.primary)*/
                        .id(ch.id)
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
        } header: { chaptersHeader() }
        .listRowBackground(Color.clear)
    }
}
