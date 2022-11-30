//
//  FilterOrder.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Order possibilities:
/// - *Ascending*
/// - *Descending*
enum FilterOrder: Pickable {
    var id: Self { self }
    
    case ascending, descending
    
    /// Order description
    var description: String {
        switch self {
        case .ascending:  return String.Filter.ascending
        case .descending: return String.Filter.descending
        }
    }
}
