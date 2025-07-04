//
//  WebsiteStandardCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

struct WebsiteStandardCell: View {
    @State var showWebView: Bool = false
    var title: String
    var urlString: String
    var image: Image
    var avatarURL: URL?
    
    var body: some View {
        content()
    }
}

struct WebsiteStandardCell_Previews: PreviewProvider {
    static var previews: some View {
        WebsiteStandardCell(
            title: "Orochii",
            urlString: "https://mangadex.org",
            image: Asset.Assets.mangaDexIcon.swiftUIImage
        )
    }
}
