//
//  Character.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation

struct Character: Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [String]
    let origin: String
    let location: String
    let url: String
    let nextPageExists: Bool
}

struct CharacterDetail: Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [Episode]
    let origin: String
    let location: String
    let url: String
    let nextPageExists: Bool
}
