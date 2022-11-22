//
//  SettingsViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var nfsw: Bool = false
    @Published var logged: Bool = false
    @Published var iCloud: Bool = false
    @Published var faceID: Bool = false
    @Published var notifications: Bool = false
    @Published var securityLevel: SecurityLevel = .library
}
