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
    @Persisted var url: String = ""
}
