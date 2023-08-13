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
            CharacterView()
                .transition(.moveAndFade)
                .tabItem {
                    Label {
                        Text("Characters", comment: "Characters tab item")
                    } icon: {
                        Image(systemName: "person.3.fill")
                    }
                }
            LocationView()
                .transition(.moveAndFade)
                .tabItem {
                    Label {
                        Text("Locations", comment: "Locations tab item")
                    } icon: {
                        Image(systemName: "location.fill")
                    }
                }
            EpisodeView()
                .transition(.moveAndFade)
                .tabItem {
                    Label {
                        Text("Episodes", comment: "Episodes tab item")
                    } icon: {
                        Image(systemName: "tv.fill")
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
