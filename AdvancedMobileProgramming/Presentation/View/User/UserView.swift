//
//  UserView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 27.07.2023.
//

import SwiftUI
import LottieSwiftUI

struct UserView: View {

    @State var isAlertPresented = false
    @ObservedObject var userViewModel = UserViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel

    var body: some View {
        GeometryReader { _ in
            VStack(alignment: .leading) {
                UserDetailView(user: userViewModel.user)
                    .padding(.init(top: 10, leading: 10, bottom: 0, trailing: 10))

                Spacer()
                LottieView(name: "lottie-user-animation")
                    .lottieLoopMode(.loop)
                    .frame(height: 250)
                Spacer()

                Button(action: {
                    self.isAlertPresented.toggle()
                }) {
                    HStack {
                        Text("Sign out")
                            .fontWeight(.bold)
                    }
                }
                .buttonStyle(AuthenticationButtonStyle())
                .padding(.bottom, 5)
            }
        }
        .background(Color(UIColors.primaryColor)
        .edgesIgnoringSafeArea(.all))
        .alert(isPresented: $isAlertPresented) {
            Alert(
                title: Text("Are you sure you want to sign out?"),
                primaryButton: .destructive(Text("Yes")) {
                    withAnimation {
                        authViewModel.signOut()
                    }
                },
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()

        UserView()
            .preferredColorScheme(.dark)
    }
}
