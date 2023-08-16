//
//  CharacterDao.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 31.07.2023.
//

import RealmSwift

// TODO: origin and location to 'Location' type

// MARK: - CharacterDao
class CharacterDao: Object {

    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var status: String = ""
    @Persisted var species: String = ""
    @Persisted var type: String = ""
    @Persisted var gender: String = ""
    @Persisted var image: String = ""
    @Persisted var episode: List<String> = List()
    @Persisted var origin: String = ""
    @Persisted var location: String = ""
    @Persisted var url: String = ""
    @Persisted var nextPageExists: Bool = false

    convenience init(
        id: Int = 0,
        name: String = "",
        status: String = "",
        species: String = "",
        type: String = "",
        gender: String = "",
        image: String = "",
        episode: List<String> = List(),
        origin: String = "",
        location: String = "",
        url: String = "",
        nextPageExists: Bool = false
    ) {
        self.init()
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.image = image
        self.episode = episode
        self.origin = origin
        self.location = location
        self.url = url
        self.nextPageExists = nextPageExists
    }

    /// Convert ``Character`` object to the ``CharacterDao`` object.
    ///
    /// - Parameter character: ``Character`` object to convert.
    /// - Returns: Converted ``CharacterDao`` object
    static func toDaoObject(character: Character) -> CharacterDao {
        let list = List<String>()
        list.append(objectsIn: character.episode)

        return CharacterDao(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            image: character.image,
            episode: list,
            origin: character.origin,
            location: character.location,
            url: character.url,
            nextPageExists: character.nextPageExists
        )
    }

    /// Convert ``CharacterResult`` object to the ``CharacterDao`` object.
    ///
    /// - Parameter character: ``CharacterResult`` object to convert.
    /// - Parameter info: ``Info`` object with additional information.
    /// - Returns: Converted ``CharacterDao`` object
    static func toDaoObject(character: CharacterResult, info: Info) -> CharacterDao {
        let list = List<String>()
        list.append(objectsIn: character.episode)

        return CharacterDao(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            image: character.image,
            episode: list,
            origin: character.origin.name,
            location: character.location.name,
            url: character.url,
            nextPageExists: info.next != nil ? true : false
        )
    }

    /// Convert ``CharacterDao`` object to the ``Character`` object.
    ///
    /// - Parameter character: ``CharacterDao`` object to convert.
    /// - Returns: Converted ``Character`` object
    static func toGeneralObject(character: CharacterDao) -> Character {
        Character(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            image: character.image,
            episode: Array(character.episode),
            origin: character.origin,
            location: character.location,
            url: character.url,
            nextPageExists: character.nextPageExists
        )
    }

}
