//
//  ChapterDomain.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/11/22.
//

import UIKit

let images = [
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A1-fea9d185476835c4dd536188b8e06d6a46716c126549058e10d3ae4bf872221a.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A2-63db781f469a288bc7324fa4ebc9815e70e7717fc33e149236fd9f3e566cb39f.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A3-b147b4143a44c758d986925149b2d31da09b9961f319b6194da8f5c7a9950500.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A4-dff831692b52efe16cc90e5c08d5065d112f245f6c06f3c2142fd7754b837393.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A5-7b3a82c682d7cd52adef4a0c15a29eb6274e88edeb502c803c1dc3a910220936.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A6-5961d57ecef874765bfd2f2b7e9706c24fd57b688946baec05b1dbd3e1139cec.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A7-8241cba49f29838745a397facf56293bff7e76e78a4a89c95020760fa0f5154f.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A8-e91494347946bb08af20259b566e73eeba0508658d5db7b1e2822121c8c7c8e6.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A9-c9599d8739a85f268de3781ec32781dd12b07ef7e6ee61efb6848c92f807280c.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A10-e8a0486cef5c7805d26c38c421cab81851aaf070d26bdc4fc792940ea4b07ecc.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A11-11b189b04ee1126d4eeff06e60892a6d948a5c479a58aa4e02f17cc0efd3d584.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A12-13bf633358cb23bf63fca2a6bb8f64e3bcbb109b7777fa95f88c50a3bc0d4194.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A13-540d144161d5ac29f9577990027da5f38bec014fc1f8c79a0a49fdf6c9af93da.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A14-d643a8cc218a56e6f357e69996839f4f21d4e3b09bcfbcf43ea11b6e10193064.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A15-026c10501d0362bc6a6463ed13c9f95e687ad0fc1715b8e150c46b8cbc96c37a.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A16-72cf5ea764fcbae5eaf80e2d4981d39a852714247a4de811bc80d66f642ef4e7.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A17-5ffbe0af3defcfe39543b390d215ddd43a809c787c3dac65bf314fc5f172f527.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A18-5780b626d3b18091042804aa54367115689aac0e3f50a3198876af3a5779da26.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A19-e313b80ad70b6a3d5f17b11cf4bb669ed6d091c9bc0bc34b3055df5f0c92b1c1.png",
    "https://uploads.mangadex.org/data/643df2588fa6bd687d336d4457d89630/A20-333982e7f2c70ee11a8161210da3cfc627041b925dd6be67c1a560f4b2d81b97.jpg"
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
    var downloaded: Bool = false
    
    static let samples: [ChapterDomain] = [
        .init(number: "1", language: "pt-br", volume: "vol. 1", title: "Ryomen Sukuna", pages: 154, updated: "2018-05-21", scanGroup: "Gravity Scans", pagesImages: images, downloaded: true),
        .init(number: "2", language: "pt-br", volume: "vol. 1", title: "Fearsome Womb", pages: 154, updated: "2019-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true, downloaded: true),
        .init(number: "3", language: "pt-br", volume: "vol. 1", title: "Young Fish and Reverse Punishment", pages: 20, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "4", language: "pt-br", volume: "vol. 2", title: "I'm Gonna Kill You!", pages: 19, updated: "2018-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "5", language: "pt-br", volume: "vol. 23", title: "Kyoto Sister School Goodwill Event", pages: 154, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images, downloaded: true),
        .init(number: "6", language: "pt-br", volume: "vol. 2", title: "Black Flash", pages: 23, updated: "2017-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "7", language: "pt-br", volume: "vol. 11", title: "The Origin of Obedience", pages: 22, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images, downloaded: true),
        .init(number: "8", language: "pt-br", volume: "vol. 19", title: "Hidden Inventory", pages: 18, updated: "2021-10-21", scanGroup: "Gravity Scans", pagesImages: images, downloaded: true),
        .init(number: "9", language: "pt-br", volume: "vol. 12", title: "Premature Death", pages: 24, updated: "2019-04-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "10", language: "pt-br", volume: "vol. 3", title: "Evening Festival", pages: 21, updated: "2022-10-21", scanGroup: "Gravity Scans", pagesImages: images, read: true),
        .init(number: "11", language: "pt-br", volume: "vol. 3", title: "The Shibuya Incident: Opening", pages: 23, updated: "2018-08-21", scanGroup: "Gravity Scans", pagesImages: images, read: true, downloaded: true),
        .init(number: "12", language: "pt-br", volume: "vol. 32", title: "The Shibuya Incident: Cloudfall", pages: 22, updated: "2022-07-21", scanGroup: "Gravity Scans", pagesImages: images),
        .init(number: "13", language: "pt-br", volume: "vol. 4", title: "The Shibuya Incident: Thunderclap", pages: 25, updated: "2021-12-21", scanGroup: "Gravity Scans", pagesImages: images, downloaded: true)
    ]
}
