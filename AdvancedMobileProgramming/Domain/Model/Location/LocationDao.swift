//
//  LocationDao.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 31.07.2023.
//

import RealmSwift

class LocationDao: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var name: String = ""
    @Persisted var type: String = ""
    @Persisted var dimension: String = ""
    @Persisted var residents: List<String> = List()
    @Persisted var url: String = ""
}
