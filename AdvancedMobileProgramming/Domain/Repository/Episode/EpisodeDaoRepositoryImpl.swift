//
//  EpisodeDaoRepositoryImpl.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try

class EpisodeDaoRepositoryImpl: DaoRepository {

    typealias T = EpisodeDao

    private var localRealm: Realm? {
        do {
            return try Realm()
        } catch {
            print("Error opening realm: \(error.localizedDescription)")
            return nil
        }
    }

    /// Read all objects from database.
    ///
    /// - Returns: list of ``EpisodeDao`` objects.
    func readAll() -> [EpisodeDao] {
        Array(localRealm!.objects(EpisodeDao.self))
    }

    /// Write all objects to the database.
    ///
    /// - Parameter objects: list of ``EpisodeDao`` objects to write to the database.
    func writeAll(objects: [EpisodeDao]) {
        try! localRealm!.write {
            localRealm!.add(objects, update: .modified)
        }
    }
}
