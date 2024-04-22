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
import class AniListService.UserMock



struct ALAccountView: View {
    @Environment(\.dismiss) 
    var dismiss
    @State var expandGenre: Bool = false
    @State var expandStartYears: Bool = false
    @State var expandCountry: Bool = false
    @State var expandStatus: Bool = false
    @State var expandTag: Bool = false
    @State var showWebView: Bool = false
    @State var showMangaView: Bool = false
    @State var showError: Bool = false
    @State var showConfirmation: Bool = false
    @StateObject var vm: ALAccountViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: CGSize.standardImageCell.width))
    ]
    
    init(user: User) {
        _vm = StateObject(wrappedValue: ALAccountViewModel(user: user))
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.ORCH.actionBackground)
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .heavy)
            ],
            for: .selected
        )
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .heavy)
            ],
            for: .normal
        )
    }
    
    var body: some View {
        NavigationStack {
            content()
                .standardBars()
                .animation(.easeIn(duration: 0.5), value: !vm.favorites.isEmpty)
                .toolbarRole(.editor)
                .alert(String.Common.error, isPresented: $vm.showAlert) {
                    Button(role: .none) { } label: {
                        Text(String.Common.ok)
                    }
                } message: {
                    Text(vm.errorMessage ?? "")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        navBarButtons()
                    }
                    
                    ToolbarItem(placement: .principal) {
                        VStack { picker() }
                    }
                }
        }
    }
}

#Preview {
    ALAccountView(user: UserMock.user)
}