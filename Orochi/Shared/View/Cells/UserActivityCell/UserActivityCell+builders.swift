//
//  UserActivityCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 31/05/23.
//

import SwiftUI
import AniListService
import Kingfisher

extension UserActivityCell {
    @ViewBuilder
    func content() -> some View {
        HStack(alignment: .top) {
            imageCover()
            info()
        }.frame(maxWidth: .infinity)
    }
    
    /// Manga image cover
    @ViewBuilder
    func imageCover() -> some View {
        if let url = URL(string: activity?.media?.coverImage?.large ?? ""),
           let mediumUrl = URL(string: activity?.media?.coverImage?.medium ?? "")  {
            KFImage.url(url)
                .fromMemoryCacheOrRefresh()
                .cacheMemoryOnly()
                .memoryCacheExpiration(.seconds(10))
                .lowDataModeSource(.network(mediumUrl))
                .fade(duration: 0.375)
                .resizable()
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
        VStack(alignment: .leading) {
            //TITLE AND PROGRESS
            titleProgress()
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack {
                //DATE
                date()
                Spacer()
                //METRICS INFORMATION
                metricsInfo()
            }
        }
        .padding(.top, 1.5)
        .frame(maxHeight: CGSize.standardImageCell.height * 0.725)
    }
    
    /// Title and progress
    @ViewBuilder
    func titleProgress() -> some View {
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
        }
    }
    
    /// Activity date
    @ViewBuilder
    func date() -> some View {
        Text("\(Date.relativeDate(of: activity?.createdAt ?? 0))")
            .foregroundColor(Color(uiColor: .systemGray))
            .font(.caption2)
            .padding(.bottom, 1.5)
    }
    
    /// Social information
    @ViewBuilder
    func metricsInfo() -> some View {
        if let likes = activity?.likes {
            HStack(spacing: .zero) {
                ForEach(likes.prefix(3).indices, id: \.self) { i in
                    if let url = URL(string: likes[i].avatar?.medium ?? "") {
                        KFImage.url(url)
                            .cacheMemoryOnly()
                            .fromMemoryCacheOrRefresh()
                            .memoryCacheExpiration(.seconds(10))
                            .fade(duration: 0.375)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 17.5, height: 17.5)
                            .background(Color(UIColor.systemGray4))
                            .clipShape(Circle())
                            .offset(x: -8.75 * CGFloat(i + 1))
                    }
                }.offset(x: 8.75 * CGFloat(likes.prefix(3).count))
                if likes.count > 3 {
                    Text("\(likes.count - 3)+")
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.systemGray))
                        .padding(.leading, 3.5)
                }
            }
        }
    }
}
