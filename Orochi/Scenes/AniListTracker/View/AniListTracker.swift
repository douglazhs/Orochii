//
//  AniListTracker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import SwiftUI

struct AniListTracker: View {
    @StateObject var vm = AniListTrackerViewModel()
    @State var sheetHeight: CGFloat = UIScreen.height
    var manga: MangaDomain
    
    init(of manga: MangaDomain) {
        self.manga = manga
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            self.mangaInfo()
            self.orderSection()
            self.scoreSection()
            self.dateSection()
        }
        .padding()
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear { sheetHeight = proxy.size.height }
                    .onChange(of: UIScreen.height) { newValue in
                        sheetHeight = proxy.size.height
                    }
            }
        }
        .listSectionSeparator(.hidden)
        .listRowBackground(Color.clear)
        .presentationDetents([.height(sheetHeight)])
        .presentationDragIndicator(.visible)
        .background(ViewBackground(with: manga.cover))
    }
}

struct AniListTracker_Previews: PreviewProvider {
    static var previews: some View {
        AniListTracker(
            of: MangaDomain.samples[0]
        )
    }
}
