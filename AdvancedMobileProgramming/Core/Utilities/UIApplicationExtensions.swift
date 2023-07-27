//
//  UIApplicationExtensions.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 26.07.2023.
//

import UIKit

extension UIApplication {

    /// Get root UIViewController of application. If for whatever reason, UIViewController cannot be accessed,
    /// invoke fatalError() since UIViewController instance is crucial for application to work properly.
    ///
    /// - Returns: root UIViewController
    static func getRootViewController() throws -> UIViewController {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first

        guard let uiViewController = window?.rootViewController else { fatalError() }
        return uiViewController
    }
}
