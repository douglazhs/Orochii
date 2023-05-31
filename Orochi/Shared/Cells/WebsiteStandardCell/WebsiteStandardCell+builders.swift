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
            HStack(alignment: .top) {
                self.link()
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
        Button {
            showWebView = true
        } label: {
            Image(appImage: image)
                .resizable()
                .cornerRadius(4.5)
                .frame(
                    width: 45.0,
                    height: 45.0
                )
        }
        .fullScreenCover(isPresented: $showWebView) {
            SafariWebView(url: URL(string: urlString)!)
                .ignoresSafeArea()
        }
    }
}
