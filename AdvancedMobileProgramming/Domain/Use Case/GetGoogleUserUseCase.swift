//
//  GetGoogleUserUseCase.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import GoogleSignIn

final class GetGoogleUserUseCase {

    init() { }

    /// Get already signed in Google user via GIDGoogleUser instance.
    ///
    /// - Parameter completionHandler: closure that returns `Result` type.
    /// GIDGoogleUser when successful and GoogleAuthenticationError in case of failure.
    func getUser(
        completionHandler: @escaping (Result<GIDGoogleUser, GoogleAuthenticationError>) -> Void
    ) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            guard error == nil else {
                completionHandler(.failure(.generalError(message: error?.localizedDescription ?? "Error occured.")))
                return
            }
            guard let user = user else {
                completionHandler(.failure(.userError))
                return
            }
            completionHandler(.success(user))
        }
    }
}
