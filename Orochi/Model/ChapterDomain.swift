//
//  ChapterDomain.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import Foundation

struct ChapterDomain: Identifiable, Hashable {
    var id = UUID()
    var number: String
    var language: String
    var volume: String
    var title: String
    var pages: Int
    var updated: String
    var scanGroup: String
    
    static let samples: [ChapterDomain] = [
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans"),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans")
    ]
}
