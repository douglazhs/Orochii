//
//  ObjectError.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 10/04/24.
//

import Foundation
enum ObjectError: Error, LocalizedError {
    case empty
    
    var localizedDescription: String {
        switch self {
        case .empty: return "Object is nil."
        }
    }
}
