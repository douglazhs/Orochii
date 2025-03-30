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
    
    /// Order key
    var key: String {
        switch self {
        case .asc: return "asc"
        case .desc: return "desc"
        }
    }
    
    /// Order title
    var description: String {
        switch self {
        case .asc:  return L.Order.ascending
        case .desc: return L.Order.descending
        }
    }
}
