//
//  LocationDaoRepositoryImpl.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try

final class LocationDaoRepositoryImpl: DaoRepository {

    typealias T = LocationDao

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
    /// - Returns: list of ``LocationDao`` objects.
    func readAll() -> [LocationDao] {
        Array(localRealm!.objects(LocationDao.self))
    }

    /// Write all objects to the database.
    ///
    /// - Parameter objects: list of ``LocationDao`` objects to write to the database.
    func writeAll(objects: [LocationDao]) {
        try! localRealm!.write {
            localRealm!.add(objects, update: .modified)
        }
    }

    /// Delete all objects of object ``LocationDao`` from the database.
    ///
    func deleteAll() {
        try! localRealm!.write {
            let episodes = localRealm!.objects(LocationDao.self)
            localRealm!.delete(episodes)
        }
    }

    /// Read all objects from database that satisfy `term` parameter.
    ///
    /// - Parameter term: term to search for in the database.
    /// - Returns: list of ``LocationDao`` objects.
    func read(where term: String) -> [LocationDao] {
        let locations = localRealm!.objects(LocationDao.self)

        let filteredLocations = locations.where { location in
            location.name.contains(term, options: .caseInsensitive)
        }

        return Array(filteredLocations)
    }

    /// Read all objects from database that satisfy `id` parameter.
    ///
    /// - Parameter id: id of the object to search for in the database.
    /// - Returns: ``LocationDetail`` object.
    func read(where id: Int) -> LocationDetail {
        let characters = localRealm!.objects(CharacterDao.self)
        let location = localRealm!
            .objects(LocationDao.self)
            .where { $0.id == id }
            .first

        let filteredCharacters = characters
            .where { $0.url.in(location?.residents ?? List<String>()) }
            .map { CharacterDao.toGeneralObject(character: $0) }

        return LocationDetail(
            id: location?.id ?? 0,
            name: location?.name ?? "",
            type: location?.type ?? "",
            dimension: location?.dimension ?? "",
            url: location?.url ?? "",
            residents: Array(filteredCharacters),
            nextPageExists: location?.nextPageExists ?? false
        )
    }
}
