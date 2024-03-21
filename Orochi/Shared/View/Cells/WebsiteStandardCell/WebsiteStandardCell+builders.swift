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
        link()
            .padding(10)
            .background(PrimaryGradient())
    }
    
    /// Link to URL
    @ViewBuilder
    func link () -> some View {
        Button {
            showWebView = true
        } label: {
            HStack(spacing: 15.0) {
                Image(appImage: image)
                    .resizable()
                    .cornerRadius(4.5)
                    .frame(
                        width: 45.0,
                        height: 45.0
                    )
                Text(title)
                    .font(.footnote)
                    .fontWeight(.medium)
                    .foregroundStyle(Color("button"))
            }
        }
        .tint(.accentColor.opacity(0.9))
        .frame(maxWidth: .infinity, alignment: .leading)
        .fullScreenCover(isPresented: $showWebView) {
            SafariWebView(url: URL(string: urlString)!)
                .ignoresSafeArea()
        }
    }
}
