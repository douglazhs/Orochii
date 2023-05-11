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
        case active, inactive, unavailable
    }
    var error: Error? = nil
    var anilistLogin: AnilistLogin = AnilistLogin()
    @Published var biometrics: Bool = false
    @Published var biometricState: LockState = .inactive
    @Published var iCloud: Bool = false
    @Published var logged: Bool = false
    @Published var biometryPreference: Bool = false
    @Published var notifications: Bool = false
    @Published var securityLevel: SecurityLevel = .library
    
    init() {
        self.biometrics = availableBiometry()
    }
    
    /// Checks the device availability of biometrics
    /// - Returns: `true`: available
    ///            `false`: not available
    func availableBiometry() -> Bool{
        let scanner = LAContext()
        var error: NSError?
        guard scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate the policy")
            self.error = error
            return false
        }
        guard error != nil else { return true }
        let code = LAError.Code(rawValue: error?.code ?? 0)
        switch code {
        case .biometryNotAvailable: return false
        case .biometryNotEnrolled:  return false
        default:                    break
        }
        return true
    }
    
    /// Change biometry state
    func changeBiometryState() {
        let scanner = LAContext()
        scanner.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Use biometrics in your app!"
        ) { status, error in
            Task { @MainActor in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                    self.biometryPreference = self.biometryPreference ? false : true
                    self.error = error
                    return
                }
                self.error = nil
                self.biometricState = (self.biometricState == .active) ? .inactive : .active
            }
        }
    }
}

