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
                .standardBars(isOpaque: Constants.device == .pad ? false : true)
                .background {
                    Asset.Colors.background.swiftUIColor
                        .ignoresSafeArea(.all)
                }
                .alert(vm.alertInfo.title, isPresented: $vm.showAlert) {
                    Button(L.Common.ok, role: .cancel) { }
                } message: {
                    Text(vm.alertInfo.message)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        mangaSourceButton()
                    }
                }
        }
        .searchable(
            text: $vm.nameQuery,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: L.Discovery.Search.placeholder
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
