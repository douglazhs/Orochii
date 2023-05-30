//
//  WebsiteStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

struct WebsiteStandardCell: View {
    var title: String
    var urlString: String
    var image: AppImages
    var avatarURL: URL? = nil
    var customInfo: String = ""
    
    var body: some View {
        self.content()
    }
}

struct WebsiteStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteStandardCell(
            title: "Title",
            urlString: "https://mangadex.org",
            image: .manga_dex_icon
        )
    }
}
