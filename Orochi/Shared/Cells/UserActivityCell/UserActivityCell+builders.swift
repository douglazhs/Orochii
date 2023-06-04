//
//  UserActivityCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 31/05/23.
//

import SwiftUI
import AniListService

extension UserActivityCell {
    @ViewBuilder
    func content() -> some View {
        HStack(alignment: .top) {
            self.imageCover()
            self.info()
        }
    }
    
    /// Manga image cover
    @ViewBuilder
    func imageCover() -> some View {
        if let url = URL(string: activity?.media?.coverImage?.extraLarge ?? "") {
            AsyncCacheImage(
                url: url,
                placeholder: { ActivityIndicator() }
            ) { image in
                Image(uiImage: image)
                    .resizable()
            }
            .cornerRadius(4.5)
            .frame(
                width: CGSize.standardImageCell.width * 0.725,
                height: CGSize.standardImageCell.height * 0.725,
                alignment: .center
            )
            .scaledToFill()
        }
    }
    
    /// Activity info
    @ViewBuilder
    func info() -> some View {
        VStack(alignment: .leading, spacing: 5.0) {
            // TITLE
            Text(activity?.media?.title?.romaji ?? "No title")
                .font(.footnote)
                .fontWeight(.semibold)
            + Text(" (\(activity?.media?.title?.english ?? "No english title"))")
                .font(.caption2)
                .fontWeight(.medium)
                .foregroundColor(Color(uiColor: .systemGray))
            
            //ACTIVITY INFORMATION
            Text("\(activity?.status?.capitalized.uppercased() ?? "Unknown status")")
                .foregroundColor(Color(uiColor: .systemGray))
                .fontWeight(.medium)
                .font(.caption2)
            + Text(" \(activity?.progress ?? "")")
                .foregroundColor(Color(uiColor: .systemGray))
                .fontWeight(.medium)
                .font(.caption2)
            
            Spacer()
            
            //DATE
            Text("\(Date.getDateBy(time: activity?.createdAt ?? 0))")
                .foregroundColor(Color(uiColor: .systemGray))
                .font(.caption2)
                .padding(.bottom, 1.5)
        }
        .padding(.top, 1.5)
        .frame(maxHeight: CGSize.standardImageCell.height * 0.725)
    }
}
