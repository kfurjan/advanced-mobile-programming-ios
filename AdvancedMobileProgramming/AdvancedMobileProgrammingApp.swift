//
//  AdvancedMobileProgrammingApp.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 24.07.2023.
//

import SwiftUI

@main
struct AdvancedMobileProgrammingApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @StateObject var viewModel = AuthenticationViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
