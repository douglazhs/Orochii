//
//  NoResults.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

struct StaticText: View {
    var message: String
    
    init(of message: String) {
        self.message = message
    }
    
    var body: some View {
        Text(message)
            .font(.callout)
            .fontWeight(.regular)
            .lineLimit(1)
            .foregroundColor(Color(uiColor: .systemGray))
            .listRowBackground(Color.clear)
    }
}

struct StaticText_Previews: PreviewProvider {
    static var previews: some View {
        StaticText(of: "NO RESULTS")
    }
}
