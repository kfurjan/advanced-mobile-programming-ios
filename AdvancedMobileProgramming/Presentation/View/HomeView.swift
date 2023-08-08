//
//  HomeView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            EpisodeView()
                .transition(.moveAndFade)
                .tabItem {
                    Label {
                        Text("Exercises", comment: "Exercises tab item")
                    } icon: {
                        Image(systemName: "heart.fill")
                    }
                }
            UserView()
                .transition(.moveAndFade)
                .tabItem {
                    Label {
                        Text("User", comment: "User tab item")
                    } icon: {
                        Image(systemName: "person.fill")
                    }
                }
        }
        .accentColor(Color(UIColors.secondaryColor))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
