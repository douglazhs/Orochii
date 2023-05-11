//
//  URLBuilder.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 06/04/23.
//

import Foundation

public class AnilistAuthenticationURLBuilder {
    /// The domain URL
    let domain: String
    /// Client ID
    let clientID: Int
    
    init(
        domain: String = "anilist.co",
        clientID: Int
    ) {
        self.domain = domain
        self.clientID = clientID
    }
    
    /// Safe URL to AniList authorize Website
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = domain
        components.path = "/api/v2/oauth/authorize"
        components.queryItems =
            [
                "client_id": String(clientID),
                "response_type": "token"
            ].map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
    
    /// Get the built URL
    /// - Returns: Built URL
    func callAsFunction() -> URL {
        url
    }
}
