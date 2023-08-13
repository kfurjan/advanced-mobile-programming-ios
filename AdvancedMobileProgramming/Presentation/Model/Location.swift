//
//  Location.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation

struct Location: Hashable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let nextPageExists: Bool
}
