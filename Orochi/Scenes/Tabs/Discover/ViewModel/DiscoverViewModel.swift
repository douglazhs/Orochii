//
//  DiscoverViewModel.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI
import MangaDex
import Combine

/// Carousel Dictionary Configuration
typealias CarouselDict = [Carousel : [Manga]]

final class DiscoverViewModel: ObservableObject, MangaHelpers {
    @Published var nameQuery: String = ""
    @Published var sections: CarouselDict = [:]
    @Published var api: MangaDexAPIProtocol = MangaDexAPI()
    @Published var searchResult: [Manga]?
    @Published var isSearching: Bool = false
    
    init() { generateSections() }
    
    /// Fetch mangas
    /// - Parameters:
    ///   - carousel: Current carousel
    ///   - completion: Manga Array
    func fetch(_ carousel: Carousel, completion: @escaping([Manga]) -> Void) {
        api.getRandomManga(params: carousel.params) { result in
            switch result {
            case .success(let array):
                completion(array.data)
            case .failure(let error): print("Fetch discovery error: \(error.localizedDescription)")
            }
        }
    }
    
    /// Search manga by name
    func search() {
        if !nameQuery.isEmpty {
            withTransaction(.init(animation: .easeInOut(duration: 0.25))) {
                isSearching = true
            }
            api.getByName(
                nameQuery,
                params: ["limit" : 20]
            ) { result in
                switch result {
                case .success(let array): 
                    self.searchResult = array.data
                    withTransaction(.init(animation: .easeInOut(duration: 0.25))) {
                        self.isSearching = false
                    }
                case .failure(let error):
                    self.searchResult = nil
                    self.isSearching = false
                    print("User search manga error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    /// Generate Main screen carousel dictionary
    /// - Returns: All main view carousel
    func generateSections() {
        Task { @MainActor in
            Carousel.allCases.forEach { type in
                switch type {
                case .latestUploaded:
                    fetch(.latestUploaded) { self.sections[type] = $0 }
                case .mostRelevants:
                    fetch(.mostRelevants) { self.sections[type] = $0 }
                case .ongoingStatus:
                    fetch(.ongoingStatus) { self.sections[type] = $0 }
                case .thisYear:
                    fetch(.thisYear) { self.sections[type] = $0 }
                case .seinen:
                    fetch(.seinen) { self.sections[type] = $0 }
                case .shounen:
                    fetch(.shounen) { self.sections[type] = $0 }
                }
            }
        }
    }
}
