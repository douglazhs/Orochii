//
//  ALAccountView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 07/03/24.
//

import Foundation
import SwiftUI
import NukeUI
import struct AniListService.User
import struct AniListService.Character
import struct AniListService.Media
import class AniListService.UserMock

struct ALAccountView: View {
    @Environment(\.dismiss) 
    var dismiss
    @State var expandGenre: Bool = false
    @State var expandChaptersPerYears: Bool = false
    @State var expandCountry: Bool = false
    @State var expandStatus: Bool = false
    @State var expandTag: Bool = false
    @State var expandStaff: Bool = false
    @State var expandCountPerYears: Bool = false
    @State var showWebView: Bool = false
    @State var showMangaView: Bool = false
    @State var showError: Bool = false
    @State var showConfirmation: Bool = false
    @StateObject var vm: ALAccountViewModel
    
    var columns = [
        GridItem(.adaptive(minimum: CGSize.standardImageCell.width))
    ]
    
    init(user: User) {
        _vm = StateObject(wrappedValue: ALAccountViewModel(user: user))
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Asset.Colors.selectedSegment.swiftUIColor)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ],
            for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)
            ],
            for: .normal
        )
    }
    
    var body: some View {
        NavigationStack {
            content()
                .standardBars()
                .toolbarBackground(.hidden, for: .navigationBar)
                .animation(.easeIn(duration: 0.5), value: !vm.favoriteMangas.isEmpty)
                .toolbarRole(.editor)
                .alert(L.Common.error, isPresented: $vm.showAlert) {
                    Button(role: .none) { } label: {
                        Text(L.Common.ok)
                    }
                } message: {
                    Text(vm.errorMessage ?? "")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        navBarButtons()
                    }
                    
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text(vm.user.name)
                                .font(.headline)
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .fontWeight(.heavy)
                        }
                    }
                }
                .fullScreenCover(isPresented: $showWebView) {
                    if let url = vm.validURL {
                        SafariWebView(
                            url: url
                        ).ignoresSafeArea()
                    }
                }
        }
    }
}

#Preview {
    ALAccountView(user: UserMock.user)
}
