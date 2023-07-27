//
//  GoogleAuthenticationError.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import Foundation

enum GoogleAuthenticationError: Error, CustomStringConvertible {

    case userError
    case generalError(message: String)

    var description: String {
        switch self {
        case .userError: return "Error when fetching user information!"
        case .generalError(let message): return message
        }
    }
}
