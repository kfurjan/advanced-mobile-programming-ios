//
//  LoginView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import SwiftUI
import LottieSwiftUI

struct LoginView: View {

    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                Spacer()

                LottieView(name: "lottie-login-animation")
                    .lottieLoopMode(.loop)
                    .frame(height: 275)

                Spacer()

                HStack {
                    Spacer()
                    LoginForm(viewModel: viewModel)
                    Spacer()
                }
            }
        }
        .background(Color(UIColors.primaryColor)
        .edgesIgnoringSafeArea(.all))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()

            LoginView()
                .preferredColorScheme(.dark)
        }
    }
}
