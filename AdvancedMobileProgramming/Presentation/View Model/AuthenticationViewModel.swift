//
//  AuthenticationViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import Firebase
import GoogleSignIn

final class AuthenticationViewModel: ObservableObject {

    enum SignInState {
      case signedIn
      case signedOut
    }

    private let getGoogleUserUseCase = GetGoogleUserUseCase()
    private let signInWithGoogleUseCase = SignInWithGoogleUseCase()

    @Published var state: SignInState = .signedOut

    init() { restorePreviousSignIn() }

    private func restorePreviousSignIn() {
        getGoogleUserUseCase.getUser { [weak self] result in
            switch result {
            case .success:
                self?.state = .signedIn
            case .failure:  // TODO: handle error cases, i.e. show message
                self?.state = .signedOut
            }
        }
    }

    func signIn() {
        signInWithGoogleUseCase.signIn { [weak self] result in
            switch result {
            case .success:
                self?.state = .signedIn
            case .failure:  // TODO: handle error cases, i.e. show message
                self?.state = .signedOut
            }
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        self.state = .signedOut
    }
}
