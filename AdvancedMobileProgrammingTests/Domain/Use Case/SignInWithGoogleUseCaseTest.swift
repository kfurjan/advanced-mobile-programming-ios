//
//  SignInWithGoogleUseCaseTest.swift
//  AdvancedMobileProgrammingTests
//
//  Created by Kevin Furjan on 20.08.2023.
//

import XCTest
import GoogleSignIn
@testable import AdvancedMobileProgramming

class SignInWithGoogleUseCaseTests: XCTestCase {

    func testSignIn_Success() {
        // Create a mock GIDSignIn instance
        let mockSignIn = MockGIDSignIn()
        GIDSignIn.sharedInstance = mockSignIn

        // Create a mock GIDSignInResult
        let mockResult = GIDSignInResult()

        // Set up the completion handler expectation
        let expectation = XCTestExpectation(description: "Completion handler called")

        // Create an instance of SignInWithGoogleUseCase
        let useCase = SignInWithGoogleUseCase()

        // Perform the test
        useCase.signIn { result in
            switch result {
            case .success(let result):
                XCTAssertEqual(result, mockResult)
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }

        // Simulate a successful sign-in by calling the mock completion handler
        mockSignIn.mockSignInCompletion?(mockResult, nil)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }

    func testSignIn_Failure() {
        // Create a mock GIDSignIn instance
        let mockSignIn = MockGIDSignIn()
        GIDSignIn.sharedInstance = mockSignIn

        // Set up the completion handler expectation
        let expectation = XCTestExpectation(description: "Completion handler called")

        // Create an instance of SignInWithGoogleUseCase
        let useCase = SignInWithGoogleUseCase()

        // Perform the test
        useCase.signIn { result in
            switch result {
            case .success:
                XCTFail("Unexpected success")
            case .failure(let error):
                XCTAssertEqual(error, .userError)
            }
            expectation.fulfill()
        }

        // Simulate a sign-in failure by calling the mock completion handler with an error
        mockSignIn.mockSignInCompletion?(nil, NSError(domain: "", code: 0, userInfo: nil))

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockGIDSignIn: GIDSignIn {
    var mockSignInCompletion: ((GIDSignInResult?, Error?) -> Void)?

    override func signIn(withPresenting viewController: UIViewController?, completion: @escaping GIDSignInHandler) {
        mockSignInCompletion = completion
    }
}
