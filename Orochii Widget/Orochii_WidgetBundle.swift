//
//  Orochii_WidgetBundle.swift
//  Orochii Widget
//
//  Created by Douglas Henrique de Souza Pereira on 19/07/25.
//

import WidgetKit
import SwiftUI

@main
struct Orochii_WidgetBundle: WidgetBundle {
    var body: some Widget {
        Orochii_Widget()
        Orochii_WidgetControl()
        Orochii_WidgetLiveActivity()
    }
}
