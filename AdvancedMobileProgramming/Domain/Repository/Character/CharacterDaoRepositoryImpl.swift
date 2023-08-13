//
//  CharacterDaoRepositoryImpl.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation
import RealmSwift

final class CharacterDaoRepositoryImpl: DaoRepository {

    typealias T = CharacterDao

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
    /// - Returns: list of ``CharacterDao`` objects.
    func readAll() -> [CharacterDao] {
        Array(localRealm!.objects(CharacterDao.self))
    }

    /// Write all objects to the database.
    ///
    /// - Parameter objects: list of ``CharacterDao`` objects to write to the database.
    func writeAll(objects: [CharacterDao]) {
        try! localRealm!.write {
            localRealm!.add(objects, update: .modified)
        }
    }

    /// Delete all objects of object ``CharacterDao`` from the database.
    ///
    func deleteAll() {
        try! localRealm!.write {
            let episodes = localRealm!.objects(CharacterDao.self)
            localRealm!.delete(episodes)
        }
    }

    /// Read all objects from database that satisfy `term` parameter.
    ///
    /// - Parameter term: term to search for in the database.
    /// - Returns: list of ``CharacterDao`` objects.
    func read(where term: String) -> [CharacterDao] {
        let characters = localRealm!.objects(CharacterDao.self)

        let filteredCharacters = characters.where { character in
            character.name.contains(term, options: .caseInsensitive)
        }

        return Array(filteredCharacters)
    }

    /// Read all objects from database that satisfy `term` parameter.
    ///
    /// - Parameter term: term to search for in the database.
    /// - Returns: list of ``CharacterDao`` objects.
    func readSpeacies(where term: String) -> [CharacterDao] {
        let characters = localRealm!.objects(CharacterDao.self)

        let filteredCharacters = characters.where { character in
            character.species.contains(term, options: .caseInsensitive)
        }

        return Array(filteredCharacters)
    }
}
