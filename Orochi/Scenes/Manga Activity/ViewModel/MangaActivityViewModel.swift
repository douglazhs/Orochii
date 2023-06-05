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
    @Published var averageColor: Color = .clear
    @Published var isLoading: Bool = false
    private var token: String = ""
    
    init(_ activity: Int) {
        self.loadToken()
        self.fetch(activity)
    }
    
    /// Fetch activity information
    /// - Parameter id: Activity Id
    func fetch(_ id: Int) {
        Task { @MainActor in
            do {
                self.activity = try await self.getActivity(
                    id: id,
                    token: token
                )
            } catch {
                dump("\(error)")
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
    
    /// Refresh activity information
    func refresh() {
        Task { @MainActor in
            guard let activity else { return }
            do {
                self.activity = try await self.getActivity(
                    id: activity.id,
                    token: token
                )
            } catch {
                dump("\(error)")
            }
        }
    }
    
    /// Send activity reply
    func sendReply() {
        Task { @MainActor in
            guard let activity else { return }
            do {
                try await self.createReply(
                    activiyId: activity.id,
                    text: text,
                    token: token
                )
            } catch {
                dump("\(error)")
            }
            self.text = ""
            self.refresh()
        }
    }
    
    /// Delete user reply
    /// - Parameter id: Reply Id
    func deleteReply(with id: Int) {
        Task { @MainActor in
            do {
                try await self.deleteReply(
                    id: id,
                    token: token
                )
            } catch {
                dump("\(error)")
            }
            self.refresh()
        }
    }
    
    /// Delete user activity
    func deleteActivity() {
        guard let activity else { return }
        Task { @MainActor in
            do {
                try await self.deleteActivity(
                    with: activity.id,
                    token: token
                )
            } catch {
                dump("\(error)")
            }
            self.refresh()
        }
    }
    
    /// Update user reply
    /// - Parameter id: Reply Id
    func updateReply(with id: Int) {
        Task { @MainActor in
            do {
                try await self.updateReply(
                    id: id,
                    text: self.text,
                    token: token
                )
            } catch {
                dump("\(error)")
            }
            self.refresh()
        }
    }
    
    /// Toggle object like
    /// - Parameters:
    ///   - id: Object id
    ///   - type: Object type
    func toggleLike(id: Int, type: LikeableType) {
        Task { @MainActor in
            do {
                try await self.toggleLike(
                    of: id,
                    as: type,
                    token: token
                )
            } catch {
                dump("\(error)")
            }
            self.refresh()
        }
    }
    
    /// Toggle activity subscription
    func toggleSubscription() {
        guard let activity else { return }
        Task { @MainActor in
            do {
                try await self.toggleSubscription(
                    id: activity.id,
                    subscribe: !(activity.isSubscribed ?? false),
                    token: token
                )
            } catch {
                dump("\(error)")
            }
            self.refresh()
        }
    }
}
