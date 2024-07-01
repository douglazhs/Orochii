//
//  CharacterView+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/06/24.
//

import SwiftUI
import MarkdownUI
import struct AniListService.Media

extension CharacterView {
    @ViewBuilder
    func content() -> some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 15.0) {
                    mainContent()
                    complementaryInfo()
                    alternativeTitles()
                    summary()
                }.padding()
                relatedMedia()
            }
        }
        .background {
            BlurBackground(
                with: URL(
                    string: character.image?.large
                    ?? character.image?.medium
                    ?? ""
                ),
                radius: 65.0,
                opacity: 0.85
            )
        }
    }
    
    @ViewBuilder
    func mainContent() -> some View {
        HStack(alignment: .top, spacing: 10.0) {
            cover()
            mainInformation()
        }
    }
    
    @ViewBuilder
    func cover() -> some View {
        MangaStandardImage(
            url: URL(
                string: character.image?.large
                ?? character.image?.medium
                ?? ""
            ),
            size: .dynamicImage
        )
    }
    
    @ViewBuilder
    func mainInformation() -> some View {
        VStack(alignment: .leading, spacing: 15.0) {
            infoLine(title: "NATIVE", character.name?.native?.notEmpty ?? "-", .leading)
            infoLine(title: "USER PREFERRED", character.name?.userPreferred?.notEmpty ?? "-", .leading)
        }
    }
    
    @ViewBuilder
    func alternativeTitles() -> some View {
        if haveAlternativeTitles {
            Divider()
            HStack(alignment: .top, spacing: 10.0) {
                mainTitles()
                
                spoilerTitles()
            }
        }
    }
    
    @ViewBuilder
    func mainTitles() -> some View {
        if let alternative = character.name?.alternative, !alternative.isEmpty {
            VStack(alignment: .leading, spacing: 5.0) {
                Text("ALTERNATIVE TITLES")
                    .foregroundStyle(Color.ORCH.secondaryTitle)
                    .font(.caption)
                VStack(alignment: .leading, spacing: 7.5) {
                    ForEach(alternative, id: \.self) {
                        Text($0)
                            .foregroundStyle(Color.ORCH.primaryText)
                            .font(.subheadline)
                    }
                }
            }
            .multilineTextAlignment(.leading)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    func spoilerTitles() -> some View {
        if let alternativeSpoilers = character.name?.alternativeSpoiler, !alternativeSpoilers.isEmpty {
            VStack(alignment: .trailing, spacing: 5.0) {
                HStack(alignment: .top) {
                    Text("SPOILER TITLES")
                        .foregroundStyle(Color.ORCH.secondaryTitle)
                        .font(.caption)
                    Button {
                        withAnimation(.bouncy) {
                            showTitlesSpoiler.toggle()
                        }
                        Haptics.shared.play(.medium)
                    } label: {
                        Image(systemName: showTitlesSpoiler ? "eye" : "eye.slash")
                            .imageScale(.small)
                    }
                    .foregroundStyle(Color.ORCH.secondaryTitle)
                }
                if showTitlesSpoiler {
                    VStack(alignment: .trailing, spacing: 7.5) {
                        ForEach(alternativeSpoilers, id: \.self) {
                            Text($0)
                                .foregroundStyle(Color.ORCH.primaryText)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    func complementaryInfo() -> some View {
        HStack {
            infoLine(
                title: "AGE",
                character.age?.last == "-"
                ? character.age?.replacingOccurrences(of: "-", with: "") ?? "-"
                : character.age.notEmpty,
                .leading
            )
            Spacer()
            infoLine(title: "GENDER", character.gender.notEmpty, .leading)
            Spacer()
            infoLine(title: "MEMBER FAVORITES", character.favourites.nilToStr, .trailing)
        }
    }
    
    @ViewBuilder
    func summary() -> some View {
        Divider()
        VStack(alignment: .leading, spacing: 7.5) {
            summaryTitle()
            summaryText()
        }
    }
    
    @ViewBuilder
    func summaryTitle() -> some View {
        HStack(alignment: .top) {
            Text("SUMMARY")
                .font(.caption)
                .foregroundStyle(Color.ORCH.secondaryTitle)
            Spacer()
            if summaryHaveSpoiler {
                Button {
                    withAnimation(.bouncy) {
                        showSummarySpoiler.toggle()
                    }
                    Haptics.shared.play(.medium)
                } label: {
                    Image(
                        systemName: showSummarySpoiler
                        ? "eye"
                        : "eye.slash"
                    )
                    .imageScale(.small)
                }
                .foregroundStyle(Color.ORCH.secondaryTitle)
            }
        }
    }
    
    /// Character summary in Markdown format
    @ViewBuilder
    func summaryText() -> some View {
        Markdown(
            showSummarySpoiler
            ? character.description?
                .replacingOccurrences(of: "~!", with: "")
                .replacingOccurrences(of: "!~", with: "") ?? String.Common.none
            : summaryHiddenSpoilers
        )
        .markdownTextStyle(\.text) {
            FontSize(15)
            FontWeight(.regular)
            ForegroundColor(Color.ORCH.primaryText)
        }
        .markdownTextStyle(\.link) {
            ForegroundColor(Color.ORCH.accentColor)
        }
        .markdownTextStyle(\.strong) {
            FontWeight(.semibold)
        }
        .markdownBlockStyle(\.listItem) { configuration in
            configuration.label.markdownMargin(top: .em(0.5))
        }
    }
    
    @ViewBuilder
    func infoLine(title: String, _ content: String, _ alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 5.0) {
            Text(title)
                .foregroundStyle(Color.ORCH.secondaryTitle)
                .font(.caption)
            Text(content)
                .foregroundStyle(Color.ORCH.primaryText)
                .font(.callout)
        }
    }
    
    /// Related manga to the character
    @ViewBuilder
    func relatedMedia() -> some View {
        if let related = character.media?.nodes {
            VStack(alignment: .leading, spacing: 15.0) {
                VStack(alignment: .leading, spacing: 15.0) {
                    Divider()
                    Text("MANGA APPEARENCES")
                        .font(.caption)
                        .foregroundStyle(Color.ORCH.secondaryTitle)
                        
                }
                .padding(.leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .top, spacing: 10.0) {
                        ForEach(related, id: \.id) { media in
                            VStack(alignment: .leading, spacing: 5.0) {
                                GridCell(
                                    coverURL: URL(
                                        string: media.coverImage?.extraLarge
                                        ?? media.coverImage?.large
                                        ?? media.coverImage?.medium
                                        ?? ""
                                    ),
                                    title: vm.unwrappedTitle(of: media)) { }
                                mediaListEntry(media)
                            }
                        }
                    }.padding([.horizontal, .bottom])
                }
            }
        }
    }
    
    @ViewBuilder
    func mediaListEntry(_ media: Media) -> some View {
        if let mediaListEntry = media.mediaListEntry {
            VStack(alignment: .leading, spacing: 5.0) {
                Text("\(mediaListEntry.status ?? "-") / CH. \(mediaListEntry.progress ?? 0)")
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                HStack(alignment: .center) {
                    Image(systemName: "star")
                    Text(
                        mediaListEntry.score ?? 0.0,
                        format: .number.precision(.fractionLength(1))
                    )
                }
            }
            .font(.caption2)
            .foregroundStyle(Color.ORCH.primaryText)
            .frame(width: CGSize.standardImageCell.width, alignment: .leading)
        }
    }
}
