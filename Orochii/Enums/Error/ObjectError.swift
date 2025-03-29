//
//  ObjectError.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 10/04/24.
//

import Foundation

/// Possible error related to the existence of an object
enum ObjectError: Error, LocalizedError {
    case empty
    
    var localizedDescription: String {
        switch self {
        case .empty: return L10n.errorNilObject
        }
    }
}
