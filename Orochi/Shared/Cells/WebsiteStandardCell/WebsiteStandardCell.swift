//
//  WebsiteStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

struct WebsiteStandardCell: View {
    var header: String
    var title: String
    var urlString: String
    var image: AppImages
    var customInfo: (show: Bool, description: String) = (show: false, description: "")
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
            HStack{
                Link(destination: URL(string: urlString)!) {
                    Image(appImage: image)
                        .resizable()
                        .cornerRadius(5.5)
                        .frame(
                            maxWidth: 45,
                            maxHeight: 45
                        )
                        .shadow(color: .black.opacity(0.3), radius: 1.5, x: 2.5, y: 2.5)
                }
                Text(title)
                Spacer()
                if customInfo.show {
                    Text(customInfo.description)
                        .font(.caption)
                }
            }
            .padding(10)
            .background(PrimaryGradient())
        }
    }
}

struct WebsiteStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteStandardCell(
            header: "Header",
            title: "Title",
            urlString: "https://mangadex.org",
            image: .ani_list_logo
        )
    }
}
