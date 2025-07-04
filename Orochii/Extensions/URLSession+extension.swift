//
//  URLSession+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 24/05/23.
//

import Foundation

extension URLSession {
    /// Download image with URL
    /// - Parameter url: Image URL
    /// - Returns: Image Data
    func downloadImage(from url: String) async throws -> Data? {
        guard let url = URL(string: url) else { return nil }
        let request = URLRequest(url: url)
        let (data, _) = try await self.data(for: request)
        return data
    }
}
