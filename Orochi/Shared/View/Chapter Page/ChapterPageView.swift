//
//  ChapterPageView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/07/23.
//

import SwiftUI
import Kingfisher

struct ChapterPageView: View {
    private let url: URL?
    private let cacheKey: String?
    @State private var total: Double = 0
    @State private var progress: Double = 0
    @State var error: Error? = nil
    
    init(url: URL?, cacheKey: String?) {
        self.url = url
        self.cacheKey = cacheKey
    }
    
    var body: some View {
        if let url, error == nil {
            KFImage.url(url, cacheKey: cacheKey)
                .fade(duration: 0.125)
                .onProgress { progress, total in
                    self.total = Double(total)
                    self.progress = Double(progress)
                }
                .onFailure { error in
                    self.error = error
                }
                .placeholder {
                    ProgressIndicator(
                        total: $total,
                        progress: $progress
                    )
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .edgesIgnoringSafeArea(.vertical)
        } else {
            Text("error")
                .font(.footnote)
                .fontWeight(.medium)
        }
    }
}

struct ChapterPageView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterPageView(
            url: nil,
            cacheKey: ""
        )
    }
}
