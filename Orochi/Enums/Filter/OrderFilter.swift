//
//  OrderFilter.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

/// Order possibilities:
/// - *Ascending*
/// - *Descending*
enum OrderFilter: Int, Pickable {
    var id: Self { self }
    
    case asc, desc
    
    /// Order description
    var description: String {
        switch self {
        case .asc:  return String.Filter.ascending
        case .desc: return String.Filter.descending
        }
    }
}
