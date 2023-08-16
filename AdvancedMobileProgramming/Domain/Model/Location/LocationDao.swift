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
    @Persisted var url: String = ""
    @Persisted var residents: List<String> = List()
    @Persisted var nextPageExists: Bool = false

    convenience init(
        id: Int = 0,
        name: String = "",
        type: String = "",
        dimension: String = "",
        url: String,
        residents: List<String> = List(),
        nextPageExists: Bool = false
    ) {
        self.init()
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.url = url
        self.residents = residents
        self.nextPageExists = nextPageExists
    }

    /// Convert ``Location`` object to the ``LocationDao`` object.
    ///
    /// - Parameter location: ``Location`` object to convert.
    /// - Returns: Converted ``LocationDao`` object
    static func toDaoObject(location: Location) -> LocationDao {
        let list = List<String>()
        list.append(objectsIn: location.residents)

        return LocationDao(
            id: location.id,
            name: location.name,
            type: location.type,
            dimension: location.dimension,
            url: location.url,
            residents: list,
            nextPageExists: location.nextPageExists
        )
    }

    /// Convert ``LocationResult`` object to the ``LocationDao`` object.
    ///
    /// - Parameter location: ``LocationResult`` object to convert.
    /// - Parameter info: ``Info`` object with additional information.
    /// - Returns: Converted ``LocationDao`` object
    static func toDaoObject(location: LocationResult, info: Info) -> LocationDao {
        let list = List<String>()
        list.append(objectsIn: location.residents)

        return LocationDao(
            id: location.id,
            name: location.name,
            type: location.type,
            dimension: location.dimension,
            url: location.url,
            residents: list,
            nextPageExists: info.next != nil ? true : false
        )
    }

    /// Convert ``LocationDao`` object to the ``Location`` object.
    ///
    /// - Parameter location: ``LocationDao`` object to convert.
    /// - Returns: Converted ``Location`` object
    static func toGeneralObject(location: LocationDao) -> Location {
        Location(
            id: location.id,
            name: location.name,
            type: location.type,
            dimension: location.dimension,
            url: location.url,
            residents: Array(location.residents),
            nextPageExists: location.nextPageExists
        )
    }
}
