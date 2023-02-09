//
//  SettingsViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI
import LocalAuthentication

class SettingsViewModel: ObservableObject {
    enum LockState {
        case active, inactive
    }
    var error: Error? = nil
    @Published var biometric: LockState = .inactive
    @Published var iCloud: Bool = false
    @Published var logged: Bool = false
    @Published var biometryPreference: Bool = false
    @Published var notifications: Bool = false
    @Published var securityLevel: SecurityLevel = .library
    
    /// Change biometry state
    func changeBiometryState() {
        let scanner = LAContext()
        var error: NSError?
        guard scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate the policy")
            return
        }
        Task { @MainActor in
            scanner.evaluatePolicy(
                .deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Use biometrics in your app!"
            ) { _, error in
                Task { @MainActor in
                    if error != nil {
                        print(error?.localizedDescription ?? "")
                        self.biometryPreference = self.biometryPreference ? false : true
                        self.error = error
                        return
                    }
                    self.error = nil
                    self.biometric = (self.biometric == .active) ? .inactive : .active
                }
            }
        }
    }
}
