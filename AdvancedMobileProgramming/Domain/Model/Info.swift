//
//  Info.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 31.07.2023.
//

import Foundation

/**
 Response `Info` struct for decoding api response info.
 ### Properties
 - **count**: The length of the response.
 - **pages**: The amount of pages.
 - **next**: Link to the next page (if it exists)
 - **prev**: Link to the previous page (if it exists).
 */
struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
