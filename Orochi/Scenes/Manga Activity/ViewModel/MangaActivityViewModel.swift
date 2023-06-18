//
//  MangaActivityViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 02/06/23.
//

import SwiftUI
import AniListService

final class MangaActivityViewModel: ObservableObject, ALServices {
    @Published var text: String = ""
    @Published var placeholder: String = "Type here..."
    @Published var activity: ActivityUnion? = nil
    @Published var canSendReply: Bool = false
    @Published var averageColor: Color = .indigo
    @Published var isLoading: Bool = false
    @Published var isRefreshing: Bool = false
    @Published var showDialog: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertInfo: AlertInfo = .init()
    private (set) var requestError: Error? = nil
    private var token: String = ""
    
    init(_ activity: Int) {
        self.loadToken()
        self.fetch(activity)
    }
    
    /// Fetch activity information
    /// - Parameter id: Activity Id
    func fetch(_ id: Int) {
        Task { @MainActor in
            isLoading = true
            defer { isLoading = false }
            do {
                self.activity = try await getActivity(
                    id: id,
                    token: token
                )
            } catch {
                isLoading = false
                requestError = error
                showAlert(error)
            }
        }
    }
    
    /// Load Bearer token from keychain
    func loadToken() {
        if let tokenData = Keychain.standard.read(
            service: "access-token",
            account: "anilist"
        ), let token =  String(
            data: tokenData,
            encoding: .utf8
        ) {
            self.token = token
        }
    }
    
    /// Verify if the user id is already saved
    /// - Returns: Logged user id
    func loggedUserId() -> Int? {
        if let userIdData = Keychain.standard.read(
            service: "user-id",
            account: "anilist"
        ), let userId = Int(data: userIdData)  {
            return userId
        }
        return nil
    }
    
    /// Vertify if the actual user is the authenticated user or not
    /// - Returns: authenticated and not authenticated
    func isCurrent(_ id: Int) -> Bool {
        if let userId = loggedUserId(),
           userId == id
        { return true }
        return false
    }
    
    /// Refresh activity information
    func refresh() {
        Task { @MainActor in
            guard let activity else { return }
            do {
                isRefreshing = true
                defer { isRefreshing = false }
                self.activity = try await self.getActivity(
                    id: activity.id,
                    token: token
                )
            } catch {
                isRefreshing = false
                requestError = error
                showAlert(error)
            }
        }
    }
    
    /// Send activity reply
    func sendReply() {
        Task { @MainActor in
            guard let activity else { return }
            do {
                try await createReply(
                    activiyId: activity.id,
                    text: text,
                    token: token
                )
            } catch {
                requestError = error
                showAlert(error)
            }
            text = ""
            refresh()
        }
    }
    
    /// Delete user reply
    /// - Parameter id: Reply Id
    func deleteReply(with id: Int) {
        Task { @MainActor in
            do {
                try await deleteReply(
                    id: id,
                    token: token
                )
            } catch {
                requestError = error
                showAlert(error)
            }
            refresh()
        }
    }
    
    /// Delete user activity
    func deleteActivity() {
        guard let activity else { return }
        Task { @MainActor in
            do {
                try await deleteActivity(
                    with: activity.id,
                    token: token
                )
            } catch {
                requestError = error
                showAlert(error)
            }
            refresh()
        }
    }
    
    /// Update user reply
    /// - Parameter id: Reply Id
    func updateReply(with id: Int) {
        Task { @MainActor in
            do {
                try await updateReply(
                    id: id,
                    text: text,
                    token: token
                )
            } catch {
                requestError = error
                showAlert(error)
            }
            refresh()
        }
    }
    
    /// Toggle object like
    /// - Parameters:
    ///   - id: Object id
    ///   - type: Object type
    func toggleLike(id: Int, type: LikeableType) {
        Task { @MainActor in
            do {
                try await toggleLike(
                    of: id,
                    as: type,
                    token: token
                )
            } catch {
                requestError = error
                showAlert(error)
            }
            refresh()
        }
    }
    
    /// Toggle activity subscription
    func toggleSubscription() {
        guard let activity else { return }
        Task { @MainActor in
            do {
                try await toggleSubscription(
                    id: activity.id,
                    subscribe: !(activity.isSubscribed ?? false),
                    token: token
                )
            } catch {
                requestError = error
                showAlert(error)
            }
            refresh()
        }
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
