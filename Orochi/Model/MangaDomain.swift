//
//  MangaDomain.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

let testDescription = "Hardship, regret, shame: the negative feelings that humans feel become Curses that lurk in our everyday lives. The Curses run rampant throughout the world, capable of leading people to terrible misfortune and even death. What's more, the Curses can only be exorcised by another Curse."

let mockLanguages: [Int : String] = [
    0: "en-US",
    1: "pt-BR",
]

struct MangaDomain: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var genres: [String]
    var status: MangaStatus
    var year: String
    var author: String
    var cover: String
    var lastUpdated: String
    var published: String
    var description: String
    var hasUpdate: Bool
    
    static let samples: [MangaDomain] = [
        .init(title: "Kaiju No. 8", genres: ["Action", "Comedy", "Drama", "Aliens", "Monsters"], status: .completed, year: "2020", author: "Matsumoto Naoya", cover: "kaiju", lastUpdated: "2022/11/29", published: "Published", description: testDescription, hasUpdate: true),
        .init(title: "Jujutsu Kaisen", genres: ["Thriller", "Magic", "Tragedy", "Ghosts", "Supernatural"], status: .completed, year: "2018", author: "Akutami Gege", cover: "jujutsu", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: false),
        .init(title: "Naruto", genres: ["Action", "Adventure", "Comedy", "Drama", "Fantasy"], status: .dropped, year: "1999", author: "Kishimoto Masashi", cover: "naruto", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: true),
        .init(title: "Chainsaw Man", genres: ["Action", "Comedy", "Demons", "Horror", "Supernatural", "Police"], status: .repeating, year: "2018", author: "Fujimoto Tatsuki", cover: "chainsaw", lastUpdated: "10/10/2022", published: "Published", description: testDescription, hasUpdate: true),
        .init(title: "Vagabond", genres: ["Action", "Adventure", "Drama", "Comedy"], status: .planning, year: "1999", author: "Takehiko Inoue", cover: "vagabond", lastUpdated: "10/10/2022", published: "Published", description: testDescription, hasUpdate: false),
        .init(title: "Mob Psycho 100", genres: ["Action", "Adventure", "Comedy", "Fantasy"], status: .planning, year: "2012", author: "One", cover: "mob", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: false),
        .init(title: "Attack on Titan", genres: ["Mystery", "Psychological", "Slice of Life"], status: .dropped, year: "2009", author: "Isayama Hajime", cover: "attack", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: true),
        .init(title: "Overlord", genres: ["Action", "Adventure", "Sci-Fi", "Isekai"], status: .completed, year: "2014", author: "Maruyama Kugane", cover: "overlord", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: true),
        .init(title: "Hunter x Hunter", genres: ["Action", "Adventure", "Slice of Life", "Medical", "Fantasy"], status: .current, year: "1998", author: "Togashi Yoshihiro", cover: "hunter", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: false),
        .init(title: "Slam Dunk!", genres: ["Delinquents", "School Life", "Comedy", "Sports", "Slice of Life"], status: .repeating, year: "1990", author: "Inoue Takehiko", cover: "slam", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: false),
        .init(title: "One Piece", genres: ["Action", "Adventure", "Comedy", "Fantasy", "Martial Arts"], status: .current, year: "1997", author: "Oda Eiichiro", cover: "onepiece", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: false),
        .init(title: "Kyuukyoku Shinka shita Full Dive RPG ga Genjitsu yori mo Kusoge Dattara", genres: ["Harem", "Video Games", "Virtual Reality", "Fantasy"], status: .dropped, year: "2021", author: "Light Tuchihi", cover: "kyuukyoku", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: true),
        .init(title: "Kimetsu no Yaiba", genres: ["Historical", "Demons", "Supernatural", "Adventure"], status: .current, year: "2014", author: "Gotouge Koyoharu", cover: "kimetsu", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: false),
        .init(title: "Fullmetal Alchemist", genres: ["Thriller", "Adventure", "Action", "Award Winning"], status: .current, year: "2001", author: "Gege Akutami", cover: "fullmetal", lastUpdated: "2022/09/10", published: "Published", description: testDescription, hasUpdate: true)
    ]
}
