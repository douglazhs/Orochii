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
    
    private (set) var biometricsError: Error? = nil
    private (set) var requestError: Error? = nil
    private (set) var anilist: AniList = AniList()
    private var token: String = ""
    @Published var biometrics: Bool = false
    @Published var biometricState: LockState = .inactive
    @Published var iCloud: Bool = false
    @Published var logged: Bool = false
    @Published var biometryPreference: Bool = false
    @Published var notifications: Bool = false
    @Published var securityLevel: SecurityLevel = .library
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var showDialog: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertInfo: AlertInfo = .init()
    
    init() {
        checkLocalAuth()
        checkALToken()
        fetchUser()
    }
    
    /// Check the avaibility of the `local authentication`
    func checkLocalAuth() {
        self.biometrics = Biometry.shared.availableBiometry { error in
            self.biometricsError = error
        }
    }
    
    /// Check if the user is logged on AniList account
    func checkALToken() {
        if let tokenData = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ), let token =  String(data: tokenData, encoding: .utf8) {
            self.token = token
            self.logged = true
        }
    }
    
    /// Fetch authenticated user
    func fetchUser() {
        Task { @MainActor in
            self.requestError = nil
            self.isLoading = true
            defer { self.isLoading = false }
            do {
                self.user = try await anilist.getAuthUser(token: token)
            } catch {
                self.requestError = error
                let failureReason = (error as? HTTPStatusCode)?.failureReason
                self.showAlert(
                    title: failureReason ?? String.Common.error,
                    message: error.localizedDescription
                )
            }
        }
    }
    
    /// Change local authentication state
    func changeLocalAuth() {
        if self.biometricsError == nil {
            Biometry.shared.changeBiometryState { error in
                self.biometricsError = error
                Task { @MainActor in
                    if error != nil {
                        self.biometryPreference = self.biometryPreference
                        ? false
                        : true
                        return
                    }
                    self.biometricState = (self.biometricState == .active)
                    ? .inactive
                    : .active
                }
            }
        }
        self.biometricsError = nil
    }
    
    /// LogIn on AniList account
    func logInAL() {
        self.anilist.logIn() { response in
            switch response {
            case .success(let token):
                do {
                    try self.storeToken(token)
                } catch {
                    self.showAlert(
                        title: String.Common.error,
                        message: String.Errors.keychainSave
                    )
                }
                self.checkALToken()
            case .fail(_):
                self.showAlert(
                    title: String.Common.error,
                    message: String.Errors.anilistLogInError
                )
            }
        }
    }
    
    /// Log Out AniList account
    func logOutAL() {
        do {
            try Keychain.standard.delete(
                service: "access-token",
                account: "anilist"
            )
            self.logged = false
            self.user = nil
        } catch {
            self.showAlert(
                title: String.Common.error,
                message: String.Errors.anilistLogOutError
            )
        }
    }
    
    /// Store Bearer token on Keychain
    /// - Parameter token: Bearer token
    func storeToken(_ token: [String:String]) throws {
        guard let bearer = token["access_token"],
              let bearerData = bearer.data(using: .utf8)
        else { return }
        try Keychain.standard.save(
            bearerData,
            service: "access-token",
            account: "anilist"
        )
    }
    
    /// Show alert
    /// - Parameters:
    ///   - title: Alert title
    ///   - message: Alert message
    func showAlert(
        title: String,
        message: String
    ) {
        self.showAlert = true
        self.alertInfo = .init(
            title: title,
            message: message
        )
    }
}

