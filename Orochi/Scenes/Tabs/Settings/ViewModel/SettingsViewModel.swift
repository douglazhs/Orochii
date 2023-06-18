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
            logged = true
            fetchUser()
        }
    }
    
    /// Verify if the user id is already saved
    /// - Returns: `true`: saved
    ///            `false`: not saved
    func savedUserId() -> Bool {
        if let userIdData = Keychain.standard.read(
            service: "user-id",
            account: "anilist"
        ), let _ = Int(data: userIdData)  {
            return true
        }
        return false
    }
    
    /// Fetch authenticated user
    func fetchUser() {
        Task { @MainActor in
            requestError = nil
            isLoading = true
            defer { isLoading = false }
            do {
                user = try await anilist.getAuthUser(token: token)
                if !self.savedUserId() {
                    if let user = self.user { try storeUser(user.id) }
                }
            } catch {
                requestError = error
                showAlert(error)
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
                    self.showAlert(error)
                }
                self.checkALToken()
            case .fail(let error):
                self.requestError = error
                self.showAlert(error)
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
            try Keychain.standard.delete(
                service: "user-id",
                account: "anilist"
            )
            token = ""
            logged = false
            user = nil
        } catch {
            showAlert(error)
        }
    }
    
    /// Store Bearer token on Keychain
    /// - Parameter token: Bearer token
    private func storeToken(_ token: [String:String]) throws {
        guard let bearer = token["access_token"],
              let bearerData = bearer.data(using: .utf8)
        else { return }
        try Keychain.standard.save(
            bearerData,
            service: "access-token",
            account: "anilist"
        )
    }
    
    
    /// Store authenticated User on Keychain
    /// - Parameter user: User to be stored
    private func storeUser(_ userId: Int) throws {
        try Keychain.standard.save(
            userId.data,
            service: "user-id",
            account: "anilist"
        )
    }
    
    /// Show alert
    /// - Parameters:
    ///   - error: Throw error
    func showAlert(_ error: Error) {
        showAlert = true
        let failureReason = (error as? HTTPStatusCode)?.failureReason
        alertInfo = .init(
            title: failureReason ?? String.Common.error,
            message: error.localizedDescription
        )
    }
}

