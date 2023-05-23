//
//  SettingsViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI
import AniListService

class SettingsViewModel: ObservableObject {
    enum LockState {
        case active, inactive, unavailable
    }
    var error: Error? = nil
    
    private (set) var anilist: AniList = AniList()
    @Published var loginMessage: String = ""
    @Published var biometrics: Bool = false
    @Published var biometricState: LockState = .inactive
    @Published var iCloud: Bool = false
    @Published var logged: Bool = false
    @Published var biometryPreference: Bool = false
    @Published var notifications: Bool = false
    @Published var securityLevel: SecurityLevel = .library
    
    init() {
        checkLocalAuth()
        checkALToken()
    }
    
    /// Check the avaibility of the `local authentication`
    func checkLocalAuth() {
        self.biometrics = Biometry.shared.availableBiometry { error in
            self.error = error
        }
    }
    
    /// Check if the user is logged on AniList account
    func checkALToken() {
        if let data = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ) { logged = true }
    }
    
    /// Change local authentication state
    func changeLocalAuth() {
        Biometry.shared.changeBiometryState { error in
            Task { @MainActor in
                if error != nil {
                    self.biometryPreference = self.biometryPreference ? false : true
                    self.error = error
                    return
                }
                self.biometricState = (self.biometricState == .active) ? .inactive : .active
            }
        }
    }
    
    /// LogIn on AniList account
    /// - Parameter showErrorDialog: Binding to show possible error messages on screen
    func logInAL(showErrorDialog: Binding<Bool>) {
        self.anilist.logIn() { response in
            switch response {
            case .success(let token):
                do {
                    try self.storeToken(token)
                } catch {
                    showErrorDialog.wrappedValue = true
                    self.loginMessage = String.Errors.keychainSave
                }
            case .fail(let error):
                showErrorDialog.wrappedValue = true
                dump(error.localizedDescription.debugDescription)
                self.loginMessage = String.Errors.anilistLogInError
            }
        }
    }
    
    /// Log Out AniList account
    /// - Parameter showErrorDialog: Binding to show possible error messages on screen
    func logOutAL(showErrorDialog: Binding<Bool>) {
        do {
            try Keychain.standard.delete(
                service: "access-token",
                account: "anilist"
            )
            self.logged = false
        } catch {
            showErrorDialog.wrappedValue = true
            loginMessage = String.Errors.anilistLogOutError
        }
    }
    
    /// Store Bearer token on Keychain
    /// - Parameter token: Bearer token
    func storeToken(_ token: [String:String]) throws {
        guard let bearer = token["access_token"],
              let bearerData = bearer.data(using: .utf8)
        else { return }
        guard let expiresIn = token["expires_in"],
              let expiresInData = expiresIn.data(using: .utf8)
        else { return }
        do {
            try Keychain.standard.save(
                bearerData,
                service: "access-token",
                account: "anilist"
            )
            try Keychain.standard.save(
                expiresInData,
                service: "expire-date",
                account: "anilist"
            )
            self.logged.toggle()
        }
    }
}

