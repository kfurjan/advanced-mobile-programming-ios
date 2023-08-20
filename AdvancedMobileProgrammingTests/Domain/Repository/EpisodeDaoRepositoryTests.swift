//
//  EpisodeDaoRepositoryTests.swift
//  AdvancedMobileProgrammingTests
//
//  Created by Kevin Furjan on 20.08.2023.
//

import XCTest
import RealmSwift
@testable import AdvancedMobileProgramming

class EpisodeDaoRepositoryTests: XCTestCase {

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

    func testReadAll() throws {
        // Create mock data
        let episodeDao = EpisodeDao()
        episodeDao.id = 1
        episodeDao.name = "Test Episode"
        try! realm.write {
            realm.add(episodeDao)
        }

        // Create an instance of EpisodeDaoRepositoryImpl
        let repository = EpisodeDaoRepositoryImpl()

        // Call the readAll method
        let episodes = repository.readAll()

        XCTAssertEqual(episodes.count, 1)
        XCTAssertEqual(episodes[0].id, 1)
        XCTAssertEqual(episodes[0].name, "Test Episode")
    }

    func testWriteAll() throws {
        // Create mock data
        let episodeDao = EpisodeDao()
        episodeDao.id = 1
        episodeDao.name = "Test Episode"

        // Create an instance of EpisodeDaoRepositoryImpl
        let repository = EpisodeDaoRepositoryImpl()

        // Call the writeAll method
        repository.writeAll(objects: [episodeDao])

        let episodes = repository.readAll()
        XCTAssertEqual(episodes.count, 1)
        XCTAssertEqual(episodes[0].id, 1)
        XCTAssertEqual(episodes[0].name, "Test Episode")
    }

    func testDeleteAll() throws {
        // Create mock data
        let episodeDao = EpisodeDao()
        episodeDao.id = 1
        episodeDao.name = "Test Episode"
        try! realm.write {
            realm.add(episodeDao)
        }

        // Create an instance of EpisodeDaoRepositoryImpl
        let repository = EpisodeDaoRepositoryImpl()

        // Call the deleteAll method
        repository.deleteAll()

        let episodes = repository.readAll()
        XCTAssertEqual(episodes.count, 0)
    }

    func testReadWhereTerm() throws {
        // Create mock data
        let episodeDao1 = EpisodeDao()
        episodeDao1.id = 1
        episodeDao1.name = "Test Episode 1"

        let episodeDao2 = EpisodeDao()
        episodeDao2.id = 2
        episodeDao2.name = "Another Episode"

        try! realm.write {
            realm.add([episodeDao1, episodeDao2])
        }

        // Create an instance of EpisodeDaoRepositoryImpl
        let repository = EpisodeDaoRepositoryImpl()

        // Call the read(where term) method
        let episodes = repository.read(where: "test")

        XCTAssertEqual(episodes.count, 1)
        XCTAssertEqual(episodes[0].id, 1)
        XCTAssertEqual(episodes[0].name, "Test Episode 1")
    }

    func testReadWhereId() throws {
        // Create mock data
        let characterDao = CharacterDao()
        characterDao.id = 1
        characterDao.name = "Test Character"

        let episodeDao = EpisodeDao()
        episodeDao.id = 1
        episodeDao.name = "Test Episode"
        episodeDao.characters.append("mock_uri")

        try! realm.write {
            realm.add(characterDao)
            realm.add(episodeDao)
        }

        // Create an instance of EpisodeDaoRepositoryImpl
        let repository = EpisodeDaoRepositoryImpl()

        // Call the read(where id) method
        let episodeDetail = repository.read(where: 1)

        XCTAssertEqual(episodeDetail.id, 1)
        XCTAssertEqual(episodeDetail.name, "Test Episode")
        XCTAssertEqual(episodeDetail.characters.count, 1)
        XCTAssertEqual(episodeDetail.characters[0].name, "Test Character")
    }
}
