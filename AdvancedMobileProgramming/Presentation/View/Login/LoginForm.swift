//
//  LoginForm.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import SwiftUI

struct GoogleAuthButton: View {
    let completionHandler: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                completionHandler()
            }
        }) {
            HStack {
                Text("Sign in with Google")
                    .fontWeight(.bold)
            }
        }
        .buttonStyle(AuthenticationButtonStyle())
    }
}

struct LoginForm: View {

    let viewModel: AuthenticationViewModel

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                GoogleAuthButton(completionHandler: viewModel.signIn)
            }
            .padding()
            .background(Color(UIColors.surfaceColor))
            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -4)
            .cornerRadius(12)
            .padding(.horizontal, 20)
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginForm(viewModel: AuthenticationViewModel())
                .previewDisplayName("Light mode")

            LoginForm(viewModel: AuthenticationViewModel())
                .previewDisplayName("Dark mode")
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
