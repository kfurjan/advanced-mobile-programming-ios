//
//  Episode.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation

struct Episode: Hashable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let nextPageExists: Bool
}
