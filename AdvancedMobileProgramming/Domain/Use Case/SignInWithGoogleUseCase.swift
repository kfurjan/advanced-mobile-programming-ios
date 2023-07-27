//
//  SignInWithGoogleUseCase.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import GoogleSignIn

final class SignInWithGoogleUseCase {

    init() { }

    /// Sign in user using Google sign-in method.
    ///
    /// - Parameter completionHandler: closure that returns `Result` type.
    /// GIDGoogleUser when successful and GoogleAuthenticationError in case of failure.
    func signIn(
        completionHandler: @escaping (Result<GIDSignInResult, GoogleAuthenticationError>) -> Void
    ) {
        do {
            let config = GIDConfiguration.getGIDConfigurationInstance()
            GIDSignIn.sharedInstance.configuration = config
            let uiViewController = try UIApplication.getRootViewController()

            GIDSignIn.sharedInstance.signIn(withPresenting: uiViewController) { signInResult, error in
                guard error == nil else {
                    completionHandler(.failure(.generalError(message: error?.localizedDescription ?? "Error occured.")))
                    return
                }
                guard let result = signInResult else {
                    completionHandler(.failure(.userError))
                    return
                }
                completionHandler(.success(result))
          }
        } catch {
            completionHandler(.failure(.generalError(message: error.localizedDescription)))
        }
    }
}
