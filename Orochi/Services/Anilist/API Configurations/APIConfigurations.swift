//
//  APIConfigurations.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 06/04/23.
//

import Foundation

public class AnilistAPIConfigurations: Codable {
    public let id: Int
    public let secret: String
    public let name: String
    public let redirectURL: URL
    
    init(
        id: Int,
        secret: String,
        name: String,
        redirectURL: URL
    ) {
        self.id = id
        self.secret = secret
        self.name = name
        self.redirectURL = redirectURL
    }
    
    static func load() -> AnilistAPIConfigurations {
        let filePath = Bundle.main.url(forResource: "anilist_api", withExtension: "json")!
        let data = try! Data(contentsOf: filePath)
        let object = try! JSONDecoder().decode(AnilistAPIConfigurations.self, from: data)
        return object
    }
}
