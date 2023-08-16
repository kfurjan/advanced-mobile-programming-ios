//
//  EpisodeDaoRepositoryImpl.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation
import RealmSwift

// swiftlint:disable force_try

final class EpisodeDaoRepositoryImpl: DaoRepository {

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

    /// Delete all objects of object ``EpisodeDao`` from the database.
    ///
    func deleteAll() {
        try! localRealm!.write {
            let episodes = localRealm!.objects(EpisodeDao.self)
            localRealm!.delete(episodes)
        }
    }

    /// Read all objects from database that satisfy `term` parameter.
    ///
    /// - Parameter term: term to search for in the database.
    /// - Returns: list of ``EpisodeDao`` objects.
    func read(where term: String) -> [EpisodeDao] {
        let episodes = localRealm!.objects(EpisodeDao.self)

        let filteredEpisodes = episodes.where { episode in
            episode.name.contains(term, options: .caseInsensitive)
        }

        return Array(filteredEpisodes)
    }

    /// Read all objects from database that satisfy `id` parameter.
    ///
    /// - Parameter id: id of the object to search for in the database.
    /// - Returns: ``EpisodeDetail`` object.
    func read(where id: Int) -> EpisodeDetail {
        let characters = localRealm!.objects(CharacterDao.self)
        let episode = localRealm!
            .objects(EpisodeDao.self)
            .where { $0.id == id }
            .first

        let filteredCharacters = characters
            .where { $0.url.in(episode?.characters ?? List<String>()) }
            .map { CharacterDao.toGeneralObject(character: $0) }

        return EpisodeDetail(
            id: episode?.id ?? 0,
            name: episode?.name ?? "",
            airDate: episode?.airDate ?? "",
            episode: episode?.episode ?? "",
            url: episode?.url ?? "",
            characters: Array(filteredCharacters),
            nextPageExists: episode?.nextPageExists ?? false
        )
    }
}
