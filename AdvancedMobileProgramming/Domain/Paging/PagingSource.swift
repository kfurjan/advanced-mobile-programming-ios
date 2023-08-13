//
//  PagingSource.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 09.08.2023.
//

import Foundation

enum LoadTypeEvent {
    case initial
    case refresh
    case append
}

protocol PagingSource {

    associatedtype Repo: ApiRepository
    associatedtype Dao: DaoRepository
    associatedtype Response
    associatedtype CustomError: Error

    var dao: Dao { get }
    var restApi: Repo { get }

    /// Main function which will load data directly from the database (if data exists), or load data from REST API,
    /// and save it to the database.
    ///
    /// - Parameters:
    ///   - page: REST API page number
    ///   - loadType: whether it is `initial`, `refresh` or `append` load event.
    ///
    /// - Returns: Returns list of generic `Response` objects, `CustomError` otherwise.
    func load(page: Int, loadType: LoadTypeEvent) async -> Result<[Response], CustomError>
}
