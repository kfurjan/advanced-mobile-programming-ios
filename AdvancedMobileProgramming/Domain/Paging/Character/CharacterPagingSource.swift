//
//  CharacterPagingSource.swift
//  AdvancedMobileProgramming
//
//  Created by Kevin Furjan on 13.08.2023.
//

import Foundation

final class CharacterPagingSource: PagingSource {

    typealias Repo = CharacterApiRepositoryImpl
    typealias Dao = CharacterDaoRepositoryImpl
    typealias Response = Character
    typealias CustomError = ApiError

    var dao: Dao = CharacterDaoRepositoryImpl()
    var restApi: Repo = CharacterApiRepositoryImpl()

    /// Main function which will load data directly from the database (if data exists), or load data from REST API,
    /// and save it to the database.
    ///
    /// - Parameters:
    ///   - page: REST API page number
    ///   - loadType: whether it is `initial`, `refresh` or `append` load event.
    ///
    /// - Returns: Returns list of ``Character`` objects, ``ApiError`` otherwise.
    func load(page: Int, loadType: LoadTypeEvent) async -> Result<[Response], CustomError> {
        switch loadType {
        case .initial:
            do {
                return .success(try await onInitialLoad(page: page))
            } catch {
                return .failure(.customError(message: "Unable to load data", comment: "ApiError.unableToLoadData"))
            }
        case .refresh:
            do {
                return .success(try await onRefresh(page: page))
            } catch {
                return .failure(.customError(message: "Could not refresh data", comment: "ApiError.couldNotRefresh"))
            }
        case .append:
            do {
                return .success(try await onAppend(page: page))
            } catch {
                return .failure(.customError(message: "Could not append data", comment: "ApiError.couldNotAppend"))
            }
        }
    }

    private func onInitialLoad(page: Int) async throws -> [Response] {
        let daoData = dao.readAll()

        if daoData.count == 0 {
            let data = try await restApi.getAll(page: page)
            dao.writeAll(objects: data.results.map { characterResult in
                CharacterDao.toDaoObject(character: characterResult, info: data.info)
            })
            return dao.readAll().map(CharacterDao.toGeneralObject)
        } else {
            return daoData.map(CharacterDao.toGeneralObject)
        }
    }

    private func onAppend(page: Int) async throws -> [Response] {
        let data = try await restApi.getAll(page: page)
        dao.writeAll(objects: data.results.map { characterResult in
            CharacterDao.toDaoObject(character: characterResult, info: data.info)
        })
        return dao.readAll().map(CharacterDao.toGeneralObject)
    }

    private func onRefresh(page: Int) async throws -> [Response] {
        dao.deleteAll()

        let data = try await restApi.getAll(page: page)
        dao.writeAll(objects: data.results.map { characterResult in
            CharacterDao.toDaoObject(character: characterResult, info: data.info)
        })

        return dao.readAll().map(CharacterDao.toGeneralObject)
    }
}
