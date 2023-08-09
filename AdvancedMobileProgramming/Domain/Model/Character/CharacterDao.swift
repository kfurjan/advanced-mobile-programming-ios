//
//  CharacterDao.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 31.07.2023.
//

import RealmSwift

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
    @Persisted var url: String = ""
    @Persisted var created: String = ""
    @Persisted var origin: CharacterOriginDao? = CharacterOriginDao()
    @Persisted var location: CharacterLocationDao? = CharacterLocationDao()
}

// MARK: - CharacterOriginDao
class CharacterOriginDao: EmbeddedObject {
    @Persisted var name: String = ""
    @Persisted var url: String = ""
}

// MARK: - CharacterOriginDao
class CharacterLocationDao: EmbeddedObject {
    @Persisted var name: String = ""
    @Persisted var url: String = ""
}
