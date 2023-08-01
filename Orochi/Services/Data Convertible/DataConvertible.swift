//
//  DataConvertible.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 18/06/23.
//

import Foundation

/// Data convertible protocol
protocol DataConvertible {
    init?(data: Data)
    
    /// Value data
    var data: Data { get }
}

extension DataConvertible where Self: ExpressibleByIntegerLiteral {
    init?(data: Data) {
        var value: Self = 0
        guard data.count == MemoryLayout.size(ofValue: value) else { return nil }
        _ = withUnsafeMutableBytes(of: &value, { data.copyBytes(to: $0)} )
        self = value
    }

    var data: Data {
        return withUnsafeBytes(of: self) { Data($0) }
    }
}

extension Int : DataConvertible { }
