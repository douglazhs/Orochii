//
//  SettingsViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 21/11/22.
//

import SwiftUI
import AniListService

class SettingsViewModel: ObservableObject {
    enum LockState: Int {
        case active, inactive, unavailable
    }
    
    private(set) var biometricsError: Error?
    private(set) var requestError: Error?
    private(set) var anilist: AniList = AniList()
    private var token: String = ""
    @Published var biometricsAvailable: Bool = false
    @Published var biometricState: LockState = .inactive
    @Published var iCloud: Bool = false
    @Published var logged: Bool = false
    @Published var biometryPreference: Bool = false
    @Published var notifications: Bool = false
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var showDialog: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertInfo: AlertInfo = .init()
    
    init() {
        loadDefaults()
        checkLocalAuth()
        checkALToken()
    }
    
    /// Load user defaults
    private func loadDefaults() {
        iCloud = Defaults.standard.getBool(of: DefaultsKeys.Settings.sync.rawValue)
        biometryPreference = Defaults.standard.getBool(of: DefaultsKeys.Settings.biometry.rawValue)
        notifications = Defaults.standard.getBool(of: DefaultsKeys.Settings.chUpdate.rawValue)
        biometricState = LockState(
            rawValue: Defaults.standard.getInt(of: DefaultsKeys.Settings.lockState.rawValue)
        ) ?? .inactive
    }
    
    /// Check the avaibility of the `local authentication`
    private func checkLocalAuth() {
        biometricsAvailable = Biometry
            .shared
            .availableBiometry {
                self.biometricsError = $0
            }
    }
    
    /// Check if the user is logged on AniList account
    private func checkALToken() {
        if let tokenData = Keychain.standard.read(
            service: KeychainService.Key.accessToken,
            account: KeychainService.Account.anilist
        ), let expiresData = Keychain.standard.read(
            service: KeychainService.Key.expiresIn,
            account: KeychainService.Account.anilist
        ),
        let token =  String(data: tokenData, encoding: .utf8),
        String(data: expiresData, encoding: .utf8) != nil {
            self.token = token
            logged = true
            fetchUser()
        }
    }
    
    /// Verify if the user id is already saved
    /// - Returns: `true`: saved
    ///            `false`: not saved
    private func savedUserId() -> Bool {
        if let userIdData = Keychain.standard.read(
            service: KeychainService.Key.userId,
            account: KeychainService.Account.anilist
        ), Int(data: userIdData) != nil {
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
                    self.biometricState = self.biometryPreference
                    ? .active
                    : .inactive
                    Defaults.standard.saveInt(
                        self.biometricState.rawValue,
                        key: DefaultsKeys.Settings.lockState.rawValue
                    )
                }
            }
        }
        self.biometricsError = nil
    }
    
    /// LogIn on AniList account
    func logInAL() {
        anilist.logIn { response in
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
                service: KeychainService.Key.accessToken,
                account: KeychainService.Account.anilist
            )
            try Keychain.standard.delete(
                service: KeychainService.Key.userId,
                account: KeychainService.Account.anilist
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
    private func storeToken(_ token: [String: String]) throws {
        guard let bearer = token["access_token"],
            let expiresDate = token["expires_in"],
            let bearerData = bearer.data(using: .utf8),
            let expiresData = expiresDate.data(using: .utf8)
        else { return }
        
        try Keychain.standard.save(
            bearerData,
            service: KeychainService.Key.accessToken,
            account: KeychainService.Account.anilist
        )
        try Keychain.standard.save(
            expiresData,
            service: KeychainService.Key.expiresIn,
            account: KeychainService.Account.anilist
        )
    }
    
    /// Store authenticated User on Keychain
    /// - Parameter user: User to be stored
    private func storeUser(_ userId: Int) throws {
        try Keychain.standard.save(
            userId.data,
            service: KeychainService.Key.userId,
            account: KeychainService.Account.anilist
        )
    }
    
    /// Show alert
    /// - Parameters:
    ///   - error: Throw error
    func showAlert(_ error: Error) {
        showAlert = true
        let failureReason = (error as? HTTPStatusCode)?.failureReason
        alertInfo = .init(
            title: failureReason ?? L.Common.error,
            message: error.localizedDescription
        )
    }
}
