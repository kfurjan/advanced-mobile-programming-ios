//
//  UIApplicationExtensionsTest.swift
//  AdvancedMobileProgrammingTests
//
//  Created by Kevin Furjan on 20.08.2023.
//

import XCTest
@testable import AdvancedMobileProgramming

final class UIApplicationExtensionsTest: XCTestCase {

    func testGetRootViewController() {
        let mockWindow = UIWindow()
        let mockViewController = UIViewController()
        mockWindow.rootViewController = mockViewController

        let mockWindowScene = UIWindowScene(session: UIWindowScene.SessionRole.mainSession)
        mockWindowScene.windows = [mockWindow]

        let mockConnectedScene = mockWindowScene as UIScene

        let mockUIApplication = MockUIApplication(connectedScenes: [mockConnectedScene])

        UIApplication.shared = mockUIApplication

        do {
            let rootViewController = try UIApplication.getRootViewController()
            XCTAssertEqual(rootViewController, mockViewController)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}

class MockUIApplication: UIApplication {
    private let connectedScenes: [UIScene]

    init(connectedScenes: [UIScene]) {
        self.connectedScenes = connectedScenes
        super.init()
    }

    override var connectedScenes: [UIScene] {
        return connectedScenes
    }
}
