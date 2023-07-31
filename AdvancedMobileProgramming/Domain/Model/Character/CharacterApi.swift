//
//  CharacterApi.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 31.07.2023.
//

import Foundation

// MARK: - CharacterApi
struct CharacterApi: Codable {
    let info: Info
    let results: [CharacterResult]
}

// MARK: - CharacterResult
struct CharacterResult: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin: CharacterOriginApi
    let location: CharacterLocationApi
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - CharacterOriginApi
struct CharacterOriginApi: Codable {
    let name: String
    let url: String
}

// MARK: - CharacterLocationApi
struct CharacterLocationApi: Codable {
    let name: String
    let url: String
}
