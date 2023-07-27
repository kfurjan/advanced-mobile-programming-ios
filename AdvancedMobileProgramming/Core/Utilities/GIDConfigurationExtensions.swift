//
//  GIDConfigurationExtensions.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import Firebase
import GoogleSignIn

extension GIDConfiguration {

    /// Get GIDConfiguration instance by providing clientID from GoogleService-Info.plist file
    ///
    /// - Returns: GIDConfiguration instance
    static func getGIDConfigurationInstance() -> GIDConfiguration {
        GIDConfiguration(clientID: FirebaseApp.app()?.options.clientID ?? "")
    }
}
