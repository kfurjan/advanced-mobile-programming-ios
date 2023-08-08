//
//  ContentView.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 24.07.2023.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        switch viewModel.state {
        case .signedIn: HomeView()
                .transition(.moveAndFade)
        case .signedOut: LoginView()
                .transition(.moveAndFade)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

        ContentView()
            .preferredColorScheme(.dark)
    }
}
