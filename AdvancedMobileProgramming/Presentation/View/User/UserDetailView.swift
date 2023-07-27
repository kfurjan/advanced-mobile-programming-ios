//
//  UserDetailView.swift
//  AdvancedMobileProgramming
//
//  Created by Ericsson on 27.07.2023..
//

import SwiftUI
import SDWebImageSwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        VStack {
            HStack {
                Text(user.fullName)
                    .bold()
                    .font(.title2)

                Spacer()

                WebImage(url: user.imageUrl)
                    .resizable()
                    .placeholder(
                        Image(systemName: "person.fill")
                    )
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .frame(width: 75, height: 75, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle())
            }
            HStack {
                Text(user.email)
                    .bold()
                    .font(.subheadline)
                Spacer()
            }

            Spacer()
        }
        .padding()
        .frame(height: 150, alignment: .center)
        .background(Color(UIColors.surfaceColor))
        .cornerRadius(12)
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(
            user: User(
                email: "kfurjan@gmail.com",
                fullName: "Kevin Furjan",
                givenName: "Kevin",
                familyName: "Furjan",
                imageUrl: URL(
                    string: "https://lh3.googleusercontent.com/a-/AOh14GhCaq3F4WH4Fzdf7Ji4yhs__ABTnR4nEKNPPgbl-sk=s75"
                )
            )
        )
        .previewLayout(.sizeThatFits)

        UserDetailView(
            user: User(
                email: "kfurjan@gmail.com",
                fullName: "Kevin Furjan",
                givenName: "Kevin",
                familyName: "Furjan",
                imageUrl: URL(
                    string: "https://lh3.googleusercontent.com/a-/AOh14GhCaq3F4WH4Fzdf7Ji4yhs__ABTnR4nEKNPPgbl-sk=s75"
                )
            )
        )
        .preferredColorScheme(.dark)
        .previewLayout(.sizeThatFits)

    }
}
