//
//  ApiRepository.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 08.08.2023.
//

/// Generic repository used for fetching data from REST API.
///
protocol ApiRepository {

    associatedtype T
    associatedtype U

    /// Generic method that fetches all data from REST API.
    ///
    /// - Returns: list of generic `T` object.
    func getAll() async throws -> T

    /// Generic method that fetches single object from REST API
    /// based on its ID.
    ///
    /// - Parameter id:ID of the REST API object.
    /// - Returns: generic `U` object.
    func getById(id: Int) async throws -> U

    /// Generic method that fetches single object from REST API
    /// based on its URI.
    ///
    /// - Parameter id:URI of the REST API object.
    /// - Returns: generic `U` object.
    func getByUri(uri: String) async throws -> U
}
