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

enum ALTab: Int, CaseIterable {
    case stats, activity,favorites
    
    var title: String {
        switch self {
        case .stats: return String.Account.stats
        case .activity: return String.Account.activity
        case .favorites: return String.Account.favorites
        }
    }
}

struct ALAccountView: View {
    @Environment(\.dismiss) var dismiss
    @State var tab: ALTab = .stats
    @State var expandGenre: Bool = false
    @State var expandStartYears: Bool = false
    @State var expandCountry: Bool = false
    @State var expandStatus: Bool = false
    @State var expandTag: Bool = false
    @State var showWebView: Bool = false
    @State var showMangaView: Bool = false
    @StateObject var vm: ALAccountViewModel
    
    init(user: User) {
        _vm = StateObject(wrappedValue: ALAccountViewModel(user: user))
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("tabBar"))
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor:UIColor.white,
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16, weight: .heavy)
        ], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor:UIColor.secondaryLabel,
            NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16, weight: .heavy)
        ], for: .normal)
    }
    
    var body: some View {
        NavigationStack {
            content()
                .standardBars()
                .animation(.easeIn(duration: 0.5), value: !vm.favorites.isEmpty)
                .toolbarRole(.editor)
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

