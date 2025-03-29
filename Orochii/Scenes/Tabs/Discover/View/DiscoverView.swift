//
//  DiscoverView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

/// Discover view style
enum ViewStyle {
    case search, initial
}

struct DiscoverView: View {
    @StateObject var vm: DiscoverViewModel
    @State var viewStyle: ViewStyle = .initial
    @State var mangaSourcePref: Bool = false
    
    init() {
        _vm = StateObject(
            wrappedValue: DiscoverViewModel()
        )
    }
    
    var body: some View {
        NavigationStack {
            content()
                .standardBars()
                .background {
                    Asset.Colors.background.swiftUIColor
                        .ignoresSafeArea(.all)
                }
                .alert(vm.alertInfo.title, isPresented: $vm.showAlert) {
                    Button(String.Common.ok, role: .cancel) { }
                } message: {
                    Text(vm.alertInfo.message)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        mangaSourceButton()
                    }
                    
                    ToolbarItem(placement: .principal) {
                        Text(String.Discovery.title)
                            .font(.title2)
                            .fontWeight(.heavy)
                    }
                }
        }
        .searchable(
            text: $vm.nameQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: String.Discovery.searchPlaceholder
        ) {
            searchSuggestions()
        }
        .onSubmit(of: .search) {
            UIApplication.shared.becomeFirstResponder()
            vm.submitSearch()
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
