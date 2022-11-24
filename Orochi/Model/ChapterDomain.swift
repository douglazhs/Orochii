//
//  ChapterDomain.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import UIKit

let images = [
    "https://uploads.mangadex.org/data/3303dd03ac8d27452cce3f2a882e94b2/1-f7a76de10d346de7ba01786762ebbedc666b412ad0d4b73baa330a2a392dbcdd.png",
    "https://uploads.mangadex.org/data/3303dd03ac8d27452cce3f2a882e94b2/2-2a5e95dfec7f15cd01f9a63835be18a22fb77a10fd2d62858c7dcbb6e6c622f9.png",
    "https://uploads.mangadex.org/data/3303dd03ac8d27452cce3f2a882e94b2/3-d06c6f764fdc3c76ea7ae3b76493fdf1a32b8926f2b60ed207b5c2fed13d002e.png",
    "https://uploads.mangadex.org/data/3303dd03ac8d27452cce3f2a882e94b2/4-a614d6456b9b13931bc5c5ef23cb5f744671f0e1e08c7335682a32de78482f71.png",
    "https://uploads.mangadex.org/data/3303dd03ac8d27452cce3f2a882e94b2/5-1105a368fd73ae99a06d7aebd165a1ff4322539ba50022a967f7b5fb0a185ce5.png",
    "https://uploads.mangadex.org/data/3303dd03ac8d27452cce3f2a882e94b2/6-e8a3eac12d879c541c4a36da550d2c69cc9450cb9b1840a079f890facf5f0c89.png"
]

struct ChapterDomain: Identifiable, Hashable {
    var id = UUID()
    var number: String
    var language: String
    var volume: String
    var title: String
    var pages: Int
    var updated: String
    var scanGroup: String
    var pagesImages: [String]
    
    static let samples: [ChapterDomain] = [
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 34", title: "Blood and war", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images)
    ]
}
