//
//  URLError.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 10/04/24.
//

import Foundation

/// Possible errors when creating URLs
enum URLError: Error, LocalizedError {
    case invalid, empty
    
    var localizedDescription: String {
        switch self {
        case .empty: return L.Error.emptyUrl
        case .invalid: return L.Error.invalidUrl
        }
    }
}
