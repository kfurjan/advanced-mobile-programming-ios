//
//  LocationApi.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 31.07.2023.
//

import Foundation

// MARK: - LocationApi
struct LocationApi: Codable {
    let info: Info
    let results: [LocationResult]
}

// MARK: - LocationResult
struct LocationResult: Codable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
