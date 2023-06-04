//
//  AsyncCacheImage.swift
//  AsyncImage
//
//  Created by Vadym Bulavin on 2/13/20.
//  Copyright © 2020 Vadym Bulavin. All rights reserved.
//

import SwiftUI

struct AsyncCacheImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    var averageColor: Binding<Color>? = nil
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    
    init(
        url: URL,
        averageColor: Binding<Color>? = nil,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        self.averageColor = averageColor
        _loader = StateObject(wrappedValue: ImageLoader(
            url: url,
            cache: Environment(\.imageCache).wrappedValue)
        )
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if let loadedImage = loader.image{
                image(loadedImage)
                    .onAppear {
                        self.averageColor?
                            .wrappedValue = Color(
                                loadedImage.averageColor
                                ?? .clear
                            )
                    }
            } else {
                placeholder
            }
        }
    }
}
