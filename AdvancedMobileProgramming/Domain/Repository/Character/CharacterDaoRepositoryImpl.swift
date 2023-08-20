//
//  CharacterDaoRepositoryImpl.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try

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

    /// Delete  object ``CharacterDao`` from the database.
    ///
    func delete(where id: Int) {
        try! localRealm!.write {
            let character = localRealm!
                .objects(CharacterDao.self)
                .where { $0.id == id }
                .first

            guard let character = character else { return }

            localRealm!.delete(character)
        }
    }

    /// Delete all objects of object ``CharacterDao`` from the database.
    ///
    func deleteAll() {
        try! localRealm!.write {
            let characters = localRealm!.objects(CharacterDao.self)
            localRealm!.delete(characters)
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

    /// Read all objects from database that satisfy `id` parameter.
    ///
    /// - Parameter id: id of the object to search for in the database.
    /// - Returns: ``CharacterDetail`` object.
    func read(where id: Int) -> CharacterDetail {
        let episodes = localRealm!.objects(EpisodeDao.self)
        let character = localRealm!
            .objects(CharacterDao.self)
            .where { $0.id == id }
            .first

        let filteredEpisodes = episodes
            .where { $0.url.in(character?.episode ?? List<String>()) }
            .map { EpisodeDao.toGeneralObject(episode: $0) }

        return CharacterDetail(
            id: character?.id ?? 0,
            name: character?.name ?? "",
            status: character?.status ?? "",
            species: character?.species ?? "",
            type: character?.type ?? "",
            gender: character?.gender ?? "",
            image: character?.image ?? "",
            episode: Array(filteredEpisodes),
            origin: character?.origin ?? "",
            location: character?.location ?? "",
            url: character?.url ?? "",
            nextPageExists: character?.nextPageExists ?? false
        )
    }
}
