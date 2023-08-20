//
//  GetGoogleUserUseCaseTest.swift
//  AdvancedMobileProgramming
//
//  Created by Ericsson on 20.08.2023..
//

import XCTest
import GoogleSignIn
@testable import AdvancedMobileProgramming

final class GetGoogleUserUseCaseTest: XCTestCase {

    func testGetUser_Success() {
        // Create a mock GIDSignIn instance
        let mockSignIn = MockGIDSignIn()
        GIDSignIn.sharedInstance = mockSignIn

        // Create a mock user
        let mockUser = GIDGoogleUser()

        // Set up the completion handler expectation
        let expectation = XCTestExpectation(description: "Completion handler called")

        // Create an instance of GetGoogleUserUseCase
        let useCase = GetGoogleUserUseCase()

        // Perform the test
        useCase.getUser { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user, mockUser)
            case .failure:
                XCTFail("Unexpected failure")
            }
            expectation.fulfill()
        }

        // Simulate a successful sign-in by calling the mock completion handler
        mockSignIn.mockRestoreCompletion?(mockUser, nil)

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetUser_Failure() {
        // Create a mock GIDSignIn instance
        let mockSignIn = MockGIDSignIn()
        GIDSignIn.sharedInstance = mockSignIn

        // Set up the completion handler expectation
        let expectation = XCTestExpectation(description: "Completion handler called")

        // Create an instance of GetGoogleUserUseCase
        let useCase = GetGoogleUserUseCase()

        // Perform the test
        useCase.getUser { result in
            switch result {
            case .success:
                XCTFail("Unexpected success")
            case .failure(let error):
                XCTAssertEqual(error, .userError)
            }
            expectation.fulfill()
        }

        // Simulate a sign-in failure by calling the mock completion handler with an error
        mockSignIn.mockRestoreCompletion?(nil, NSError(domain: "", code: 0, userInfo: nil))

        // Wait for the expectation to be fulfilled
        wait(for: [expectation], timeout: 1.0)
    }
}

class MockGIDSignIn: GIDSignIn {

    init() {}
    var mockRestoreCompletion: ((GIDGoogleUser?, Error?) -> Void)?

    override func restorePreviousSignIn(completion: @escaping (GIDGoogleUser?, Error?) -> Void) {
        mockRestoreCompletion = completion
    }
}
