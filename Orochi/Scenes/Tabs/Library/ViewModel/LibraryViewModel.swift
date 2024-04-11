//
//  LibraryViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import SwiftUI

class LibraryViewModel: ObservableObject {
    let years = [Int](stride(from: 2000, through: 2022, by: 1))
    @Published var query: String = ""
    @Published var objectFilter: ObjectFilter = .name
    @Published var filterOrder: OrderFilter = .asc
    @Published var languageSelection: Language = .enUS
    @Published var yearSelection: Int = 2000
    @Published var demoPublicSelection: DemoPublic = .shounen
    
    // MARK: Biometrics
    enum LockState: Int {
        case active, inactive, unavailable
    }
    
    @Published var biometricsError: Error?
    @Published var availableBiometricsError: Error?
    @Published var biometricsAvailable: Bool = false
    @Published var biometricsState: LockState = .inactive
    @Published var unlocked: Bool = true
    @Published var lockClick: Bool?
    
    init() {
        loadDefaults()
        checkLocalAuth()
        unlocked = (biometricsState == .inactive)
        ? true
        : false
    }
    
    /// Load user defaults
    func loadDefaults() {
        biometricsState = LockState(
            rawValue: Defaults
                .standard
                .getInt(
                    of: DefaultsKeys.Settings.lockState.rawValue
                )
        ) ?? .inactive
    }
    
    /// Check the avaibility of the `local authentication`
    private func checkLocalAuth() {
        biometricsAvailable = Biometry.shared.availableBiometry { error in
            self.availableBiometricsError = error
        }
    }
    
    /// Check local auth
    func localAuth() {
        biometricsError = nil
        
        if biometricsState == .active && !unlocked {
            if availableBiometricsError == nil {
                Biometry.shared.changeBiometryState { error in
                    self.biometricsError = error
                    Task { @MainActor in
                        withAnimation(.linear(duration: 0.25)) {
                            self.unlocked = error == nil
                            self.lockClick = nil
                        }
                    }
                }
            }
        }
    }
    
    /// Lock library action
    func lock() {
        withAnimation(.linear(duration: 0.25)) {
            unlocked = false
            lockClick = true
        }
    }
    
    /// Unlock library action
    func unlock() {
        withAnimation(.linear(duration: 0.25)) {
            unlocked = true
            lockClick = nil
        }
    }
}
