//
//  String+replacing.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/06/24.
//

import Foundation

extension String {

    mutating func replace(from: String, to: String, by new: String) {
        guard let from = range(of: from)?.lowerBound, let to = range(of: to)?.upperBound else { return }

        let range = from..<to
        self = replacingCharacters(in: range, with: new)
    }

    func replaced(from: String, to: String, by new: String) -> String {
        guard let from = range(of: from)?.lowerBound, let to = range(of: to)?.upperBound else { return self }

        let range = from..<to
        return replacingCharacters(in: range, with: new)
    }

}
