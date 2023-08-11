//
//  EpisodeDao.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 31.07.2023.
//

import RealmSwift

class EpisodeDao: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var airDate: String = ""
    @Persisted var episode: String = ""
    @Persisted var characters: List<String> = List()
    @Persisted var nextPageExists: Bool = false

    convenience init(
      id: Int,
      name: String,
      airDate: String,
      episode: String,
      characters: List<String>,
      nextPageExists: Bool
    ) {
        self.init()
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episode = episode
        self.characters = characters
        self.nextPageExists = nextPageExists
    }

    /// Convert ``Episode`` object to the ``EpisodeDao`` object.
    ///
    /// - Parameter episode: ``Episode`` object to convert.
    /// - Returns: Converted ``EpisodeDao`` object
    static func toDaoObject(episode: Episode) -> EpisodeDao {
        let list = List<String>()
        list.append(objectsIn: episode.characters)

        return EpisodeDao(
            id: episode.id,
            name: episode.name,
            airDate: episode.airDate,
            episode: episode.episode,
            characters: list,
            nextPageExists: episode.nextPageExists
        )
    }

    /// Convert ``EpisodeResult`` object to the ``EpisodeDao`` object.
    ///
    /// - Parameter episode: ``EpisodeResult`` object to convert.
    /// - Parameter info: ``Info`` object with additional information.
    /// - Returns: Converted ``EpisodeDao`` object
    static func toDaoObject(episode: EpisodeResult, info: Info) -> EpisodeDao {
        let list = List<String>()
        list.append(objectsIn: episode.characters)

        return EpisodeDao(
            id: episode.id,
            name: episode.name,
            airDate: episode.airDate,
            episode: episode.episode,
            characters: list,
            nextPageExists: info.next != nil ? true : false
        )
    }

    /// Convert ``EpisodeDao`` object to the ``Episode`` object.
    ///
    /// - Parameter episode: ``EpisodeDao`` object to convert.
    /// - Returns: Converted ``Episode`` object
    static func toGeneralObject(episode: EpisodeDao) -> Episode {
        Episode(
            id: episode.id,
            name: episode.name,
            airDate: episode.airDate,
            episode: episode.episode,
            characters: Array(episode.characters),
            nextPageExists: episode.nextPageExists
        )
    }
}
