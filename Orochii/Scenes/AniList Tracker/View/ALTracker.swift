//
//  ALTracker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import SwiftUI
import struct MangaDex.Manga
import class MangaDex.MangaMock

struct ALTracker: View {
    @Environment(\.isSearching)
    var isSearching
    @Environment(\.dismissSearch) 
    var dismissSearch
    @Environment(\.dismiss) 
    var dismiss
    @StateObject var vm: ALTrackerViewModel
    @State var showNumberPicker: Bool = false
    @State var showTextField: Bool = false
    @State var showWebView: Bool = false
    @State var showConfirmation: Bool = false
    var cover: URL?
    var action: Binding<Bool>
    
    init(
        of manga: Manga,
        cover: URL? = nil,
        action: Binding<Bool>
    ) {
        _vm = StateObject(wrappedValue: ALTrackerViewModel(manga)) 
        self.cover = cover
        self.action = action
    }
    
    var body: some View {
        NavigationStack {
            content()
                .standardBars()
                .onSubmit(of: .search) { dismissSearch() }
                .navigationBarTitleDisplayMode(.inline)
                .animation(.easeIn, value: [vm.mangas != nil])
                .toolbarRole(.editor)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if vm.availableInAL {
                            anilistMangaOptions()
                        }
                    }
                    ToolbarItem(placement: .principal) { alTitleView() }
                    ToolbarItem(placement: .status) {
                        switch vm.context {
                        case .tracker:
                            if vm.trackingLocally {
                                saveButton()
                            }
                        case .search:
                            trackButton()
                        }
                    }
                }
        }
    }
}

#Preview {
    ALTracker(
        of: MangaMock.manga,
        cover: MangaMock.coverUrl,
        action: .constant(false)
    )
}
