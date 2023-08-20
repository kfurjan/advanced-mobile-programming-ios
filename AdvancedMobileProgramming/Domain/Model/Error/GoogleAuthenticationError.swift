//
//  GoogleAuthenticationError.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import Foundation

enum GoogleAuthenticationError: Error, CustomStringConvertible, Equatable, Localizable {

    case userError
    case generalError(message: String)

    var description: String {
        switch self {
        case .userError:
            return "Error when fetching user information!"
        case .generalError(let message):
            return message
        }
    }

    var localizedDescription: String {
        switch self {
        case .userError:
            return NSLocalizedString(
                "Error when fetching user information!",
                comment: "GoogleAuthenticationError.userError"
            )
        case .generalError(let message):
            return message
        }
    }
}
