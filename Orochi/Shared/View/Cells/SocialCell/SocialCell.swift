//
//  SocialCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import SwiftUI
import struct AniListService.User

struct SocialCell: View {
    var user: User?
    var action: ((SocialAction, User?) -> Void)?
    
    var body: some View {
        self.content()
            .frame(maxWidth: .infinity)
    }
}

struct SocialCell_Previews: PreviewProvider {
    static var previews: some View {
        SocialCell()
    }
}
