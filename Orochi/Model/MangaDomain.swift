//
//  MangaDomain.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 19/11/22.
//

import SwiftUI

let description = "Hardship, regret, shame: the negative feelings that humans feel become Curses that lurk in our everyday lives. The Curses run rampant throughout the world, capable of leading people to terrible misfortune and even death. What's more, the Curses can only be exorcised by another Curse."

struct MangaDomain: Identifiable {
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
}

let samples: [MangaDomain] = [
    .init(title: "Kaiju No. 8", genres: ["Thriller", "Monsters", "Magic"], status: .ongoing, year: "2018", author: "Gege Akutami", cover: "kaiju", lastUpdated: "2022-09-10", published: "Published", description: description),
    .init(title: "JUJUTSU KAISEN", genres: ["Thriller", "Monsters", "Magic"], status: .completed, year: "2018", author: "Eiichiro Oda", cover: "jujutsu", lastUpdated: "2022-09-10", published: "Published", description: description),
    .init(title: "Naruto Shippuden", genres: ["Thriller", "Monsters", "Magic"], status: .hiatus, year: "2018", author: "Gege Akutami", cover: "naruto", lastUpdated: "2022-09-10", published: "Published", description: description),
    .init(title: "Mob Psycho 100", genres: ["Thriller", "Monsters", "Magic"], status: .hiatus, year: "2018", author: "Masashi Kishimoto", cover: "mob", lastUpdated: "2022-09-10", published: "Published", description: description),
    .init(title: "Attack on Titan", genres: ["Thriller", "Monsters", "Magic"], status: .ongoing, year: "2018", author: "Masashi Kishimoto", cover: "attack", lastUpdated: "2022-09-10", published: "Published", description: description),
    .init(title: "Overlord", genres: ["Thriller", "Monsters", "Magic"], status: .completed, year: "2018", author: "Gege Akutami", cover: "overlord", lastUpdated: "2022-09-10", published: "Published", description: description)
]
