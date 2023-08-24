//
//  ALTracker.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import SwiftUI
import struct MangaDex.Manga

struct ALTracker: View {
    @Environment(\.isSearching) var isSearching
    @Environment(\.dismissSearch) var dismissSearch
    @Environment(\.dismiss) var dismiss
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
                .onSubmit(of: .search, { dismissSearch() })
                .navigationBarTitleDisplayMode(.inline)
                .animation(.easeIn, value: [vm.mangas != nil])
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if vm.availableInAL {
                            anilistMangaOptions()
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        closeButton()
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

struct ALTracker_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
