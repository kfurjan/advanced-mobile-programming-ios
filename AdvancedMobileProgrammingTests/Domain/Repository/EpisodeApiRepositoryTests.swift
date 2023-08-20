//
//  EpisodeApiRepositoryTests.swift
//  AdvancedMobileProgrammingTests
//
//  Created by Kevin Furjan on 20.08.2023.
//

import XCTest
import Alamofire
@testable import AdvancedMobileProgramming

class EpisodeApiRepositoryTests: XCTestCase {

    // Mock Alamofire for testing
    class MockAFSession: Session {
        override func request(
            _ convertible: URLConvertible,
            method: HTTPMethod = .get,
            parameters: Parameters? = nil,
            encoding: ParameterEncoding = URLEncoding.default,
            headers: HTTPHeaders? = nil
        ) -> DataRequest {
            let url = try! convertible.asURL()
            let data = "{}".data(using: .utf8)!
            let urlResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            let result = Result<Data, AFError>.success(data)
            return DataRequest(
                convertible: convertible,
                underlyingQueue: .main,
                serializationQueue: .main,
                eventMonitor: nil,
                interceptor: nil,
                delegate: nil
            )
                .response(urlResponse: urlResponse, data: data, error: nil, result: result)
        }
    }

    func testGetAll() async throws {
        // Create a mock EpisodeApi
        let mockEpisodeApi = EpisodeApi()

        // Set up the mock AF session for Alamofire
        let mockSession = MockAFSession()
        AF.session = mockSession

        // Create an instance of EpisodeApiRepositoryImpl
        let repository = EpisodeApiRepositoryImpl()

        // Call the getAll method and await the result
        let result = try await repository.getAll()

        XCTAssertEqual(result, mockEpisodeApi)
    }

    func testGetById() async throws {
        // Create a mock EpisodeResult
        let mockEpisodeResult = EpisodeResult()

        // Set up the mock AF session for Alamofire
        let mockSession = MockAFSession()
        AF.session = mockSession

        // Create an instance of EpisodeApiRepositoryImpl
        let repository = EpisodeApiRepositoryImpl()

        // Call the getById method and await the result
        let result = try await repository.getById(id: 1)

        XCTAssertEqual(result, mockEpisodeResult)
    }

    func testGetByUri() async throws {
        // Create a mock EpisodeResult
        let mockEpisodeResult = EpisodeResult()

        // Set up the mock AF session for Alamofire
        let mockSession = MockAFSession()
        AF.session = mockSession

        // Create an instance of EpisodeApiRepositoryImpl
        let repository = EpisodeApiRepositoryImpl()

        // Call the getByUri method and await the result
        let result = try await repository.getByUri(uri: "mock_uri")

        XCTAssertEqual(result, mockEpisodeResult)
    }
}
