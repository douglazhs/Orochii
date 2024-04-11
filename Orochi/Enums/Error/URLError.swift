//
//  URLError.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 10/04/24.
//

import Foundation

enum URLError: Error, LocalizedError {
    case invalid, empty
    
    var localizedDescription: String {
        switch self {
        case .empty: return "Empty URL."
        case .invalid: return "Invalid URL."
        }
    }
}
