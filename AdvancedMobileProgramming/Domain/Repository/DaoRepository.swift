//
//  DaoRepository.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

import Foundation

/// Generic repository for accessing database.
///
protocol DaoRepository {

    associatedtype T

    /// Read all objects from database.
    ///
    /// - Returns: list of generic `T` objects.
    func readAll() -> [T]

    /// Write all objects to the database.
    ///
    /// - Parameter objects: list of generic `T` objects to write to the database.
    func writeAll(objects: [T])

    /// Delete all objects of object `T` from the database.
    ///
    func deleteAll()

    /// Read all objects from database that satisfy `term` parameter.
    ///
    /// - Parameter term: term to search for in the database.
    /// - Returns: list of generic `T` objects.
    func read(where term: String) -> [T]
}
