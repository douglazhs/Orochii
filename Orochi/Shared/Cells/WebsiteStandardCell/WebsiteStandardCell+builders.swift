//
//  WebsiteStandardCell+builders.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import SwiftUI

extension WebsiteStandardCell {
    /// View content
    @ViewBuilder
    func content() -> some View {
        VStack(alignment: .leading) {
            Text(header).unredacted()
            HStack(alignment: .top) {
                self.link()
                Text(title)
                    .fontWeight(.semibold)
                Spacer()
                Text(customInfo)
                    .font(.caption)
            }
            .padding(10)
            .background(PrimaryGradient())
        }
    }
    
    /// Link to URL
    @ViewBuilder
    func link () -> some View {
        Link(destination: URL(string: urlString)!) {
            if let url = avatarURL {
                AsyncImage(
                    url: url,
                    transaction: .init(animation: .easeIn(duration: 0.3))
                ) { image in
                    if let image = image.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(5.5)
                    }
                    if let _ = image.error { self.unableToLoad() }
                }
            } else {
                Image(appImage: image)
                    .resizable()
                    .cornerRadius(5.5)
            }
        }
        .frame(
            width: 45,
            height: 45
        )
    }
    
    /// Unable to load image from URL view
    @ViewBuilder
    func unableToLoad() -> some View {
        Text("UNABLE TO LOAD")
            .font(.caption2)
            .fontWeight(.regular)
            .foregroundColor(Color(uiColor: .systemGray))
            .unredacted()
    }
}
