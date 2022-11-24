//
//  Image+appImages.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 22/11/22.
//

import SwiftUI

/// App standrd images
enum AppImages: String {
    case manga_dex_icon, ani_list_logo, view_background
}

extension Image {
    /// Custom Image constructor
    init(appImage: AppImages){
        self = Image(appImage.rawValue)
    }
}
