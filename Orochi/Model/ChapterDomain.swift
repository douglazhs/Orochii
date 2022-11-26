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
    var read: Bool = false
    
    static let samples: [ChapterDomain] = [
        .init(number: "1", language: "pt-br", volume: "VOL. 1", title: "Ryomen Sukuna", pages: 154, updated: "2018-05-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "2", language: "pt-br", volume: "VOL. 1", title: "Fearsome Womb", pages: 154, updated: "2019-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "3", language: "pt-br", volume: "VOL. 1", title: "Young Fish and Reverse Punishment", pages: 20, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "4", language: "pt-br", volume: "VOL. 2", title: "I'm Gonna Kill You!", pages: 19, updated: "2018-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "5", language: "pt-br", volume: "VOL. 2", title: "Kyoto Sister School Goodwill Event", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "6", language: "pt-br", volume: "VOL. 2", title: "Black Flash", pages: 23, updated: "2017-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "7", language: "pt-br", volume: "VOL. 2", title: "The Origin of Obedience", pages: 22, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "8", language: "pt-br", volume: "VOL. 3", title: "Hidden Inventory", pages: 18, updated: "2021-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "9", language: "pt-br", volume: "VOL. 3", title: "Premature Death", pages: 24, updated: "2019-04-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "VOL. 3", title: "Evening Festival", pages: 21, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "11", language: "pt-br", volume: "VOL. 3", title: "The Shibuya Incident: Opening", pages: 23, updated: "2018-08-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "12", language: "pt-br", volume: "VOL. 4", title: "The Shibuya Incident: Cloudfall", pages: 22, updated: "2022-07-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "13", language: "pt-br", volume: "VOL. 4", title: "The Shibuya Incident: Thunderclap", pages: 25, updated: "2021-12-21", scanGroup: "Gravity Scans", pagesImages: images)
    ]
}
