//
//  ApiError.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 01.08.2023.
//

import Foundation

enum ApiError: Error, Localizable {
    case badRequest
    case notFound
    case noSuchEntity
    case unableToDetchData
    case databaseException
    case serializationException
    case customError(message: String)

    var localizedDescription: String {
        switch self {
        case .badRequest:
            return NSLocalizedString("Bad request!", comment: "ApiError.badRequest")
        case .notFound:
            return NSLocalizedString("Not found!", comment: "ApiError.notFound")
        case .noSuchEntity:
            return NSLocalizedString("No such entity!", comment: "ApiError.noSuchEntity")
        case .unableToDetchData:
            return NSLocalizedString("Unable to fetch data!", comment: "ApiError.unableToDetchData")
        case .databaseException:
            return NSLocalizedString("Database error occured!", comment: "ApiError.databaseException")
        case .serializationException:
            return NSLocalizedString("Request body had incorrect format!", comment: "ApiError.serializationException")
        case .customError(let message):
            return message
        }
    }
}
