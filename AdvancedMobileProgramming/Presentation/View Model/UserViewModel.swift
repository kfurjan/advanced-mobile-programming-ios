//
//  UserViewModel.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import Foundation
import GoogleSignIn

final class UserViewModel: ObservableObject {

    private let getGoogleUserUseCase = GetGoogleUserUseCase()

    @Published private(set) var user = User(
        email: "",
        fullName: "",
        givenName: "",
        familyName: "",
        imageUrl: URL(string: "")
    )

    init() { getUserInformation() }

    private func getUserInformation() {
        getGoogleUserUseCase.getUser { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = User(
                    email: user.profile?.email ?? "",
                    fullName: user.profile?.name ?? "",
                    givenName: user.profile?.givenName ?? "",
                    familyName: user.profile?.familyName ?? "",
                    imageUrl: user.profile?.imageURL(withDimension: 75)
                )
            case .failure:  // TODO: handle error cases, i.e. show message
                return
            }
        }
    }
}
