//
//  Biometry.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/05/23.
//

import LocalAuthentication

final class Biometry {
    static var shared = Biometry()
    
    /// Checks the device availability of biometrics
    /// - Returns: `true`: available
    ///            `false`: not available
    func availableBiometry(completion: @escaping (Error?) -> Void) -> Bool {
        let scanner = LAContext()
        var error: NSError?
        guard scanner.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate the policy")
            completion(error)
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
    /// - Parameter completion: Possible error
    func changeBiometryState(completion: @escaping (Error?) -> Void) {
        let scanner = LAContext()
        scanner.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Use biometrics in your app!"
        ) { status, error in
            completion(error)
            return
        }
    }
}
