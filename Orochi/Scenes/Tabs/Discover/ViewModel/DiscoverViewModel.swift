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

class DiscoverViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var sections: CarouselDict = [:]
    @Published var api: MangaDexAPIProtocol = MangaDexAPI()
    @Published var searchResult: [Manga]?
    
    init() {
        generateSections()
    }
    
    /// Fetch mangas
    /// - Parameters:
    ///   - carousel: Current carousel
    ///   - completion: Manga Array
    func fetch(_ carousel: Carousel, completion: @escaping([Manga]) -> Void) {
        api.getRandomManga(params: carousel.params) { result in
            switch result {
            case .success(let array):
                completion(array.data)
            case .failure(let error): print("\(error.localizedDescription)")
            }
        }
    }
    
    /// Search manga by name
    func search() {
        api.getByName(name: searchText, params: ["limit" : 20]) { result in
            switch result {
            case .success(let array):
                self.searchResult = array.data
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    /// Generate Main screen carousel dictionary
    /// - Returns: All main view carousel
    func generateSections() {
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
    
    /// Get cover art file name
    /// - Parameter manga: Current manga
    /// - Returns: Cover art file name
    func fileName(of manga: Manga) -> String {
        guard let cover = manga.relationships?.first(where: { $0.type == "cover_art" }),
              let fileName = cover.attributes?.fileName else {
            return ""
        }
        return fileName
    }
}
