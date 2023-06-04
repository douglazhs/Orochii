//
//  UserActivityCell.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 31/05/23.
//

import SwiftUI
import struct AniListService.ActivityUnion

struct UserActivityCell: View {
    var activity: ActivityUnion?
    
    var body: some View {
        self.content()
    }
}

struct UserActivityCell_Previews: PreviewProvider {
    static var previews: some View {
        UserActivityCell()
    }
}
