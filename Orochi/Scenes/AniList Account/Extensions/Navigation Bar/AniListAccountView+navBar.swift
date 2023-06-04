//
//  AniListAccountView+navBar.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI

extension AniListAccountView {
    /// Button to see the profile on the web browser
    @ViewBuilder
    func profileWeb() -> some View {
        Button {
            UIApplication.shared
                .safariVC(url: vm.user?.siteUrl ?? "")
        } label: { Image(systemName: "safari.fill") }
    }
}
