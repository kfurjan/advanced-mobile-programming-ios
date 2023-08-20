//
//  EpisodePagingSourceTests.swift
//  AdvancedMobileProgrammingTests
//
//  Created by Kevin Furjan on 20.08.2023.
//

import XCTest
import RealmSwift
@testable import YourAppName  // Replace with your actual app's module

class MockEpisodeApiRepository: EpisodeApiRepositoryImpl {
    var mockGetAllCompletion: ((Int, LoadTypeEvent) -> Result<EpisodeApi, ApiError>)?

    override func getAll(page: Int) async throws -> EpisodeApi {
        guard let completion = mockGetAllCompletion else {
            fatalError("Mock completion is not set for getAll")
        }
        return try completion(page, .initial).get()
    }
}

class EpisodePagingSourceTests: XCTestCase {

    var realm: Realm!

    override func setUp() {
        super.setUp()
        // Use an in-memory Realm for testing
        Realm.Configuration.defaultConfiguration = Realm.Configuration(inMemoryIdentifier: "testRealm")
        realm = try! Realm()
    }

    override func tearDown() {
        // Clean up and release resources
        try! realm.write {
            realm.deleteAll()
        }
        realm.invalidate()
        super.tearDown()
    }

    func testLoad_Initial() async throws {
        // Create mock Episode data from REST API
        let mockEpisode = Episode(id: 1, name: "Test Episode")
        let mockResponse: [Episode] = [mockEpisode]

        // Create mock EpisodeApiRepositoryImpl
        let mockApiRepository = MockEpisodeApiRepository()
        mockApiRepository.mockGetAllCompletion = { _, _ in
            .success(EpisodeApi(results: [EpisodeResult(from: mockEpisode)], info: EpisodeInfo()))
        }

        // Create an instance of EpisodePagingSource
        let pagingSource = EpisodePagingSource()
        pagingSource.restApi = mockApiRepository

        // Call the load method with initial load event
        let result = try await pagingSource.load(page: 1, loadType: .initial)

        // Check if the correct data was returned
        switch result {
        case .success(let episodes):
            XCTAssertEqual(episodes.count, 1)
            XCTAssertEqual(episodes[0].id, 1)
            XCTAssertEqual(episodes[0].name, "Test Episode")
        case .failure:
            XCTFail("Unexpected failure")
        }
    }

    func testOnInitialLoad() async throws {
        // Create mock Episode data from REST API
        let mockEpisode = Episode(id: 1, name: "Test Episode")
        let mockResponse: [Episode] = [mockEpisode]

        // Create mock EpisodeApiRepositoryImpl
        let mockApiRepository = MockEpisodeApiRepository()
        mockApiRepository.mockGetAllCompletion = { _, _ in
            .success(EpisodeApi(results: [EpisodeResult(from: mockEpisode)], info: EpisodeInfo()))
        }

        // Create an instance of EpisodePagingSource
        let pagingSource = EpisodePagingSource()
        pagingSource.restApi = mockApiRepository

        // Call the onInitialLoad method
        let episodes = try await pagingSource.onInitialLoad(page: 1)

        XCTAssertEqual(episodes.count, 1)
        XCTAssertEqual(episodes[0].id, 1)
        XCTAssertEqual(episodes[0].name, "Test Episode")
    }
}
