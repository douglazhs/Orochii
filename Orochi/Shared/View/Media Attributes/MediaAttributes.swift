//
//  MediaAttribute.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/07/23.
//

import SwiftUI

struct MediaAttributes: View {
    let leading: (title: String, value: String)
    let trailing: (title: String, value: String)
    
    var body: some View {
        infoLine(leading: leading, trailing: trailing)
    }
}

struct MediaAttribute_Previews: PreviewProvider {
    static var previews: some View {
        MediaAttributes(
            leading: (title: "A", value: "B"),
            trailing: (title: "C", value: "D")
        )
    }
}
