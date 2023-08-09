//
//  StringConstants.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import Foundation

// MARK: UI colors defined in Assets

enum UIColors {
    static let primaryColor = "PrimaryColor"
    static let surfaceColor = "SurfaceColor"
    static let secondaryColor = "SecondaryColor"
    static let onSurfaceColor = "OnSurfaceColor"
    static let onSecondaryColor = "OnSecondaryColor"
}

// MARK: API endpoints

enum ApiEndpoints {
    private static let httpType = "https"
    private static let hostname = "rickandmortyapi.com"
    private static let apiVersion = "api"

    static let episode = "\(httpType)://\(hostname)/\(apiVersion)/episode"
    static let location = "\(httpType)://\(hostname)/\(apiVersion)/location"
    static let character = "\(httpType)://\(hostname)/\(apiVersion)/character"
}

// MARK: UserDefaultStrings

enum UserDefaultStrings {
    static let episodePage = "episodePage"
    static let locationPage = "locationPage"
    static let characterPage = "characterPage"
}
