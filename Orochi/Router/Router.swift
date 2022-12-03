//
//  Router.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 01/12/22.
//

import SwiftUI

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    func reset() {
        path = NavigationPath()
    }
}
